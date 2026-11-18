// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/MyCourseRatingCubit/my_course_rating_cubit.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingDisplay.dart';
import 'package:sintir/Core/widgets/Rating/StarRatingInput.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView_item.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ExpandableReviewText.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/RateCourseBottomSheet.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class MyCourseRatingSection extends StatelessWidget {
  const MyCourseRatingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyCourseRatingCubit, MyCourseRatingState>(
      buildWhen: (previous, current) =>
          previous.myFeedback != current.myFeedback ||
          previous.action != current.action ||
          previous.loadStatus != current.loadStatus ||
          previous.stats != current.stats,
      builder: (context, state) {
        final mine = state.myFeedback;
        if (mine == null) {
          final isFirst =
              state.loadStatus == CourseRatingLoadStatus.loaded &&
              !state.stats.hasRatings &&
              state.stats.feedBacksCount == 0;
          return RateCourseCard(
            title: isFirst ? LocaleKeys.noReviewsYet : LocaleKeys.rateCourse,
            subtitle: isFirst
                ? LocaleKeys.beFirstToRate
                : LocaleKeys.rateCourseSubtitle,
            enabled: !state.isBusy,
            onRate: (star) =>
                showRateCourseBottomSheet(context, initialRating: star),
          );
        }
        return MyReviewCard(
          review: mine,
          busy: state.isBusy,
          deleting: state.action == CourseRatingAction.deleting,
        );
      },
    );
  }
}

class RateCourseCard extends StatelessWidget {
  const RateCourseCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onRate,
    this.enabled = true,
  });

  final String title;
  final String subtitle;
  final ValueChanged<int> onRate;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final styles = AppTextStyles(context);
    final mutedColor = theme.textTheme.bodySmall?.color;
    return Container(
      key: const ValueKey('rate-course-card'),
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 22, 16, 14),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            textAlign: TextAlign.center,
            style: styles.bold16.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: styles.regular13.copyWith(color: mutedColor, height: 1.6),
          ),
          const SizedBox(height: 8),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: StarRatingInput(
              value: 0,
              enabled: enabled,
              keyPrefix: 'inline-star-rating',
              onChanged: onRate,
            ),
          ),
          Text(
            LocaleKeys.tapStarToRate,
            textAlign: TextAlign.center,
            style: styles.regular12.copyWith(color: mutedColor),
          ),
        ],
      ),
    );
  }
}

class MyReviewCard extends StatelessWidget {
  const MyReviewCard({
    super.key,
    required this.review,
    this.busy = false,
    this.deleting = false,
  });

  final CoursefeedbackItemEntity review;
  final bool busy;
  final bool deleting;

  Future<void> _delete(BuildContext context) async {
    final cubit = context.read<MyCourseRatingCubit>();
    if (await confirmDeleteMyReview(context)) await cubit.delete();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final styles = AppTextStyles(context);
    final locale = Localizations.localeOf(context).languageCode;
    final mutedColor = theme.textTheme.bodySmall?.color;
    final rating = review.rating;
    final text = review.fedBack.trim();
    final editColor = isDark
        ? const Color(0xFFB3C5FA)
        : const Color(0xFF2F55C8);
    final deleteColor = isDark
        ? const Color(0xFFFF8A80)
        : const Color(0xFFC62828);

    return Container(
      key: const ValueKey('my-course-review'),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Semantics(
                header: true,
                child: Text(
                  LocaleKeys.yourReview,
                  style: styles.bold16.copyWith(
                    color: theme.textTheme.bodyLarge?.color,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  reviewMetaText(review, locale),
                  key: const ValueKey('my-review-meta'),
                  textAlign: TextAlign.end,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: styles.regular12.copyWith(color: mutedColor),
                ),
              ),
            ],
          ),
          if (rating != null) ...[
            const SizedBox(height: 10),
            Row(
              children: [
                StarRatingDisplay(
                  rating: rating.toDouble(),
                  size: 20,
                  semanticLabel: LocaleKeys.ratingOutOfFive('$rating'),
                ),
                const SizedBox(width: 10),
                Flexible(
                  child: Text(
                    LocaleKeys.ratingLabel(rating),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: styles.semiBold13.copyWith(color: mutedColor),
                  ),
                ),
              ],
            ),
          ],
          if (text.isNotEmpty) ...[
            const SizedBox(height: 10),
            ExpandableReviewText(
              text: text,
              style: styles.regular14.copyWith(
                color: theme.textTheme.bodyMedium?.color,
                height: 1.7,
              ),
            ),
          ],
          const SizedBox(height: 14),
          Row(
            children: [
              Expanded(
                child: TextButton.icon(
                  key: const ValueKey('edit-my-review'),
                  onPressed: busy
                      ? null
                      : () => showRateCourseBottomSheet(context),
                  style: TextButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    backgroundColor: KMainColor.withValues(
                      alpha: isDark ? 0.2 : 0.12,
                    ),
                    foregroundColor: editColor,
                    textStyle: styles.semiBold14,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(Icons.edit_outlined, size: 18),
                  label: Text(LocaleKeys.editReview),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton.icon(
                  key: const ValueKey('delete-my-review'),
                  onPressed: busy ? null : () => _delete(context),
                  style: OutlinedButton.styleFrom(
                    minimumSize: const Size.fromHeight(44),
                    foregroundColor: deleteColor,
                    side: BorderSide(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.14)
                          : Colors.black.withValues(alpha: 0.14),
                    ),
                    textStyle: styles.semiBold14,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: deleting
                      ? SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: deleteColor,
                          ),
                        )
                      : const Icon(Icons.delete_outline, size: 18),
                  label: Text(LocaleKeys.delete),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

Future<bool> confirmDeleteMyReview(BuildContext context) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      content: Text(LocaleKeys.deleteReviewConfirm),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(false),
          child: Text(LocaleKeys.cancel),
        ),
        TextButton(
          key: const ValueKey('confirm-delete-review'),
          onPressed: () => Navigator.of(dialogContext).pop(true),
          child: Text(
            LocaleKeys.delete,
            style: const TextStyle(color: Colors.red),
          ),
        ),
      ],
    ),
  );
  return confirmed ?? false;
}
