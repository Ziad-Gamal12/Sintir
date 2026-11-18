// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/MyCourseRatingCubit/my_course_rating_cubit.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/course_feedback_error_messages.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingInput.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

void showRateCourseBottomSheet(BuildContext context, {int? initialRating}) {
  final cubit = context.read<MyCourseRatingCubit>();
  showCustomBottomSheet(
    context: context,
    child: BlocProvider.value(
      value: cubit,
      child: RateCourseBottomSheet(initialRating: initialRating),
    ),
  );
}

class RateCourseBottomSheet extends StatefulWidget {
  const RateCourseBottomSheet({super.key, this.initialRating});

  final int? initialRating;

  @override
  State<RateCourseBottomSheet> createState() => _RateCourseBottomSheetState();
}

class _RateCourseBottomSheetState extends State<RateCourseBottomSheet> {
  late int _rating;
  late final TextEditingController _textController;
  String? _ratingError;

  String? _serverError;

  @override
  void initState() {
    super.initState();
    final mine = context.read<MyCourseRatingCubit>().state.myFeedback;
    final initial = widget.initialRating;
    _rating = initial != null && initial >= 1 && initial <= 5
        ? initial
        : mine?.rating ?? 0;
    _textController = TextEditingController(text: mine?.fedBack ?? '');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _save() {
    setState(() => _serverError = null);
    if (_rating == 0) {
      setState(() => _ratingError = LocaleKeys.ratingRequired);
      return;
    }
    FocusScope.of(context).unfocus();
    context.read<MyCourseRatingCubit>().save(
      rating: _rating,
      text: _textController.text,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final styles = AppTextStyles(context);
    return BlocConsumer<MyCourseRatingCubit, MyCourseRatingState>(
      listenWhen: (previous, current) => previous.action != current.action,
      listener: (context, state) {
        if (state.action == CourseRatingAction.saved) {
          Navigator.of(context).pop();
        } else if (state.action == CourseRatingAction.saveFailed) {
          setState(
            () => _serverError =
                state.errorMessage ?? LocaleKeys.errorOccurredMessage,
          );
        }
      },
      builder: (context, state) {
        final busy = state.isBusy;
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.viewInsetsOf(context).bottom,
          ),
          child: SafeArea(
            top: false,
            child: SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: Container(
                      width: 40,
                      height: 4,
                      decoration: BoxDecoration(
                        color: theme.dividerColor,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    state.hasMyRating
                        ? LocaleKeys.editYourRating
                        : LocaleKeys.rateCourse,
                    textAlign: TextAlign.center,
                    style: styles.bold18.copyWith(
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: StarRatingInput(
                      value: _rating,
                      enabled: !busy,
                      onChanged: (value) => setState(() {
                        _rating = value;
                        _ratingError = null;
                        _serverError = null;
                      }),
                    ),
                  ),
                  const SizedBox(height: 4),
                  ConstrainedBox(
                    constraints: const BoxConstraints(minHeight: 26),
                    child: Center(
                      child: _ratingError != null
                          ? Text(
                              _ratingError!,
                              textAlign: TextAlign.center,
                              style: styles.regular12.copyWith(
                                color: Colors.red,
                              ),
                            )
                          : _rating > 0
                          ? Text(
                              LocaleKeys.ratingLabel(_rating),
                              key: const ValueKey('rating-label'),
                              style: styles.bold16.copyWith(
                                color: StarRatingDisplay.starColor,
                              ),
                            )
                          : null,
                    ),
                  ),
                  const SizedBox(height: 12),
                  CustomTextField(
                    key: const ValueKey('rating-review-text'),
                    hintText: LocaleKeys.reviewTextHint,
                    obscureText: false,
                    controller: _textController,
                    textInputType: TextInputType.multiline,
                    validator: null,
                    maxLines: 4,
                    maxLength: maxCourseFeedbackLength,
                  ),
                  if (_serverError != null) ...[
                    const SizedBox(height: 12),
                    Row(
                      key: const ValueKey('rating-server-error'),
                      children: [
                        const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            _serverError!,
                            style: styles.regular12.copyWith(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 16),
                  Custombutton(
                    key: const ValueKey('save-rating-button'),
                    text: LocaleKeys.saveRating,
                    color: KMainColor,
                    textColor: Colors.white,
                    onPressed: busy ? () {} : _save,
                    child: state.action == CourseRatingAction.saving
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2.5,
                              color: Colors.white,
                            ),
                          )
                        : null,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
