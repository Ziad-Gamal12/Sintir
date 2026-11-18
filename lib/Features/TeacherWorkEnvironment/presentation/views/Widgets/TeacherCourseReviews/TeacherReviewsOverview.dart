// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFeedbackSkeleton.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseRatingSummaryCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherCourseReviews/TeacherReviewsInsightsRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_course_reviews_cubit/teacher_course_reviews_cubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherReviewsOverview extends StatelessWidget {
  const TeacherReviewsOverview({super.key});

  static bool _shouldRebuild(
    TeacherCourseReviewsState previous,
    TeacherCourseReviewsState current,
  ) =>
      previous.overviewStatus != current.overviewStatus ||
      previous.stats != current.stats ||
      previous.insights != current.insights ||
      previous.query.star != current.query.star ||
      _listFailed(previous) != _listFailed(current);

  static bool _listFailed(TeacherCourseReviewsState state) =>
      state.listStatus == ReviewsLoadStatus.failure;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TeacherCourseReviewsCubit>();
    return BlocBuilder<TeacherCourseReviewsCubit, TeacherCourseReviewsState>(
      buildWhen: _shouldRebuild,
      builder: (context, state) {
        switch (state.overviewStatus) {
          case ReviewsLoadStatus.initial:
          case ReviewsLoadStatus.loading:
            return const RatingSummaryLoadingPlaceholder();
          case ReviewsLoadStatus.failure:
            if (_listFailed(state)) return const SizedBox.shrink();
            return _OverviewUnavailable(onRetry: cubit.loadOverview);
          case ReviewsLoadStatus.loaded:
            if (!state.stats.hasRatings) return const SizedBox.shrink();
            final insights = state.insights;
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CourseRatingSummaryCard(
                  stats: state.stats,
                  selectedStar: state.query.star,
                  onStarSelected: cubit.toggleStar,
                ),
                if (insights != null) ...[
                  const SizedBox(height: 12),
                  TeacherReviewsInsightsRow(insights: insights),
                ],
              ],
            );
        }
      },
    );
  }
}

class _OverviewUnavailable extends StatelessWidget {
  const _OverviewUnavailable({required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return Container(
      key: const ValueKey('teacher-reviews-overview-unavailable'),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF2C2C2C) : const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              LocaleKeys.ratingSummaryUnavailable,
              style: AppTextStyles(
                context,
              ).regular14.copyWith(color: theme.textTheme.bodyMedium?.color),
            ),
          ),
          TextButton(onPressed: onRetry, child: Text(LocaleKeys.reviewsRetry)),
        ],
      ),
    );
  }
}
