// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/AppConfirmationSheet.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ReportReviewSheet.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ReviewActionsMenu.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ReviewReplySheet.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView_item.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFeedbackSkeleton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherCourseReviews/TeacherReviewsEmptyState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_course_reviews_cubit/teacher_course_reviews_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class TeacherReviewsSliverList extends StatelessWidget {
  const TeacherReviewsSliverList({super.key});

  static bool _shouldRebuild(
    TeacherCourseReviewsState previous,
    TeacherCourseReviewsState current,
  ) =>
      previous.listStatus != current.listStatus ||
      previous.reviews != current.reviews ||
      previous.loadingMore != current.loadingMore ||
      previous.pageFailed != current.pageFailed ||
      previous.query != current.query ||
      previous.lastSeenAt != current.lastSeenAt;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherCourseReviewsCubit>();
    return BlocBuilder<TeacherCourseReviewsCubit, TeacherCourseReviewsState>(
      buildWhen: _shouldRebuild,
      builder: (context, state) {
        switch (state.listStatus) {
          case ReviewsLoadStatus.initial:
          case ReviewsLoadStatus.loading:
            return const SliverToBoxAdapter(child: ReviewsLoadingPlaceholder());
          case ReviewsLoadStatus.failure:
            return SliverToBoxAdapter(
              child: _ListFailure(
                message: state.errorMessage ?? LocaleKeys.errorOccurredMessage,
                onRetry: () {
                  cubit.retryList();
                  if (!cubit.state.statsReady) cubit.loadOverview();
                },
              ),
            );
          case ReviewsLoadStatus.loaded:
            if (state.reviews.isEmpty) {
              return SliverToBoxAdapter(
                child: TeacherReviewsEmptyState(
                  filtered: !state.query.isNewest,
                  onShowAll: () =>
                      cubit.selectQuery(CourseReviewsQuery.newest),
                ),
              );
            }
            return _ReviewsList(state: state, onRetryPage: cubit.retryPage);
        }
      },
    );
  }
}

class _ReviewsList extends StatelessWidget {
  const _ReviewsList({required this.state, required this.onRetryPage});

  final TeacherCourseReviewsState state;
  final VoidCallback onRetryPage;

  @override
  Widget build(BuildContext context) {
    final reviews = state.reviews;
    final hasFooter = state.loadingMore || state.pageFailed;
    final dividerColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.white.withValues(alpha: 0.08)
        : Colors.black.withValues(alpha: 0.08);

    return SliverList.separated(
      itemCount: reviews.length + (hasFooter ? 1 : 0),
      separatorBuilder: (context, index) =>
          Divider(height: 1, thickness: 1, color: dividerColor),
      itemBuilder: (context, index) {
        if (index == reviews.length) {
          return state.loadingMore
              ? const Padding(
                  padding: EdgeInsets.symmetric(vertical: 16),
                  child: Center(
                    child: CircularProgressIndicator(color: KMainColor),
                  ),
                )
              : Center(
                  child: TextButton(
                    key: const ValueKey('teacher-reviews-retry-page'),
                    onPressed: onRetryPage,
                    child: Text(LocaleKeys.reviewsRetry),
                  ),
                );
        }
        final review = reviews[index];
        return CoursefedbackslistviewItem(
          key: ValueKey('teacher-review-${review.uid}'),
          item: review,
          isNew: state.isNew(review),
          trailing: ReviewActionsMenu(
            hasReply: review.teacherReply != null,
            onReply: () => _reply(context, review),
            onDeleteReply: () => _deleteReply(context, review),
            onReport: () => _report(context, review),
          ),
        );
      },
    );
  }
}

Future<void> _reply(BuildContext context, CoursefeedbackItemEntity review) async {
  final cubit = context.read<TeacherCourseReviewsCubit>();
  final saved = await ReviewReplySheet.show(
    context,
    initialText: review.teacherReply?.text ?? '',
    onSubmit: (text) => cubit.saveReply(review, text),
  );
  if (saved && context.mounted) {
    CustomSnackBar.show(
      context,
      message: LocaleKeys.reviewReplySaved,
      type: SnackType.success,
    );
  }
}

Future<void> _deleteReply(
  BuildContext context,
  CoursefeedbackItemEntity review,
) async {
  final cubit = context.read<TeacherCourseReviewsCubit>();
  final confirmed = await AppConfirmationSheet.show(
    context,
    icon: Icons.delete_outline_rounded,
    color: ReviewActionsMenu.danger,
    title: LocaleKeys.reviewReplyDeleteTitle,
    body: LocaleKeys.reviewReplyDeleteBody,
    confirmLabel: LocaleKeys.reviewReplyDelete,
  );
  if (!confirmed) return;
  final failure = await cubit.deleteReply(review);
  if (!context.mounted) return;
  CustomSnackBar.show(
    context,
    message: failure ?? LocaleKeys.reviewReplyDeleted,
    type: failure == null ? SnackType.success : SnackType.error,
  );
}

Future<void> _report(BuildContext context, CoursefeedbackItemEntity review) async {
  final cubit = context.read<TeacherCourseReviewsCubit>();
  final sent = await ReportReviewSheet.show(
    context,
    onSubmit: (reason, details) => cubit.reportReview(review, reason, details),
  );
  if (sent && context.mounted) {
    CustomSnackBar.show(
      context,
      message: LocaleKeys.reviewReportSent,
      type: SnackType.success,
    );
  }
}

class _ListFailure extends StatelessWidget {
  const _ListFailure({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Padding(
      key: const ValueKey('teacher-reviews-failure'),
      padding: const EdgeInsets.symmetric(vertical: 32),
      child: CustomErrorWidget(errormessage: message, onRetry: onRetry),
    );
  }
}
