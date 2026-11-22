import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/AppConfirmationSheet.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CoursedetailsviewOptionitemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_actions.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_management_tile.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_metadata.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_poster.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_state_notice.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/course_detail_summary.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/UpdateCourseCubit/Update_Course_Cubit.dart';
import 'package:sintir/locale_keys.dart';

class CourseDetailScreenBody extends StatefulWidget {
  const CourseDetailScreenBody({super.key, required this.course});

  final CourseEntity course;

  @override
  State<CourseDetailScreenBody> createState() => _CourseDetailScreenBodyState();
}

class _CourseDetailScreenBodyState extends State<CourseDetailScreenBody> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateCourseCubit, UpdateCourseState>(
      listener: _handleCourseUpdate,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final state = TeacherCourseState.fromRaw(widget.course.state);
          final managementItems = CoursedetailsviewOptionitemEntity.toList(
            context: context,
            course: widget.course,
          );
          final overview = <Widget>[
            CourseDetailPoster(course: widget.course),
            if (CourseDetailStateNotice.showsFor(state)) ...[
              const SizedBox(height: 12),
              BlocSelector<UpdateCourseCubit, UpdateCourseState, bool>(
                selector: (s) => s is UpdateCourseStateLoading,
                builder: (context, resubmitting) => CourseDetailStateNotice(
                  state: state,
                  declineReason: widget.course.declineReason,
                  declinedAt: widget.course.declinedAt,
                  resubmitting: resubmitting,
                  onResubmit: state == TeacherCourseState.declined
                      ? () => _confirmResubmit(context)
                      : null,
                ),
              ),
            ],
            const SizedBox(height: 16),
            CourseDetailSummary(course: widget.course),
            const SizedBox(height: 12),
            CourseDetailMetadata(course: widget.course),
          ];
          final management = <Widget>[
            _ManagementSectionHeader(),
            const SizedBox(height: 10),
            ...managementItems.map(
              (item) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: CourseDetailManagementTile(item: item),
              ),
            ),
            const SizedBox(height: 10),
            CourseDetailActions(course: widget.course),
          ];

          if (constraints.maxWidth >= Breakpoints.expanded) {
            final gutter = ContentWidth.gutter(
              constraints.maxWidth,
              ContentWidth.detail,
              min: 24,
            );
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(gutter, 16, gutter, 32),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: overview,
                    ),
                  ),
                  const SizedBox(width: 24),
                  Expanded(
                    flex: 6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: management,
                    ),
                  ),
                ],
              ),
            );
          }

          final contentWidth = constraints.maxWidth
              .clamp(0.0, 760.0)
              .toDouble();
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Center(
              child: SizedBox(
                width: contentWidth,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    ...overview,
                    const SizedBox(height: 22),
                    ...management,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Future<void> _confirmResubmit(BuildContext context) async {
    final cubit = context.read<UpdateCourseCubit>();
    final confirmed = await AppConfirmationSheet.show(
      context,
      icon: Icons.send_rounded,
      color: KMainColor,
      title: LocaleKeys.courseResubmitTitle,
      body: LocaleKeys.courseResubmitBody,
      confirmLabel: LocaleKeys.courseResubmitButton,
    );
    if (!confirmed || !mounted) return;
    await cubit.resubmitForReview(courseEntity: widget.course);
  }

  void _handleCourseUpdate(BuildContext context, UpdateCourseState state) {
    if (state is UpdateCourseSuccess) {
      widget.course.state = UpdateCourseCubit.stateAfterEdit(
        widget.course.state,
      );
      setState(() {});
    } else if (state is UpdateCourseStateSuccess) {
      widget.course.state = state.courseEntity.state;
      CustomSnackBar.show(
        context,
        message: state.resubmitted
            ? LocaleKeys.courseResubmitDone
            : LocaleKeys.operationSuccessful,
        type: SnackType.success,
      );
      setState(() {});
    } else if (state is UpdateCourseStateFailure) {
      CustomSnackBar.show(
        context,
        message: state.errmessage,
        type: SnackType.error,
      );
    }
  }
}

class _ManagementSectionHeader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);

    return Row(
      children: [
        Expanded(
          child: Text(
            LocaleKeys.courseManagement,
            style: textStyles.bold20.copyWith(
              color: theme.textTheme.bodyLarge?.color,
            ),
          ),
        ),
        Text(
          LocaleKeys.courseManagementCount,
          style: textStyles.regular12.copyWith(
            color: theme.textTheme.bodySmall?.color,
          ),
        ),
      ],
    );
  }
}
