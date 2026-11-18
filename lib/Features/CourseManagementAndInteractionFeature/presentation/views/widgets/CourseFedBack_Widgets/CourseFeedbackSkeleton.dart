// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseFedBacksListView_item.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/CourseRatingSummaryCard.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/MyCourseRatingSection.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseFedBack_Widgets/ReviewsSectionTitle.dart';
import 'package:sintir/locale_keys.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseFeedbackSkeleton extends StatelessWidget {
  const CourseFeedbackSkeleton({super.key, required this.showRateCard});

  final bool showRateCard;

  @override
  Widget build(BuildContext context) {
    return _LoadingSemantics(
      child: Skeletonizer(
        enabled: true,
        child: ListView(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
          children: [
            const CourseRatingSummaryCard(stats: _placeholderStats),
            if (showRateCard) ...[
              const SizedBox(height: 16),
              RateCourseCard(
                title: LocaleKeys.rateCourse,
                subtitle: LocaleKeys.rateCourseSubtitle,
                onRate: (_) {},
              ),
            ],
            const SizedBox(height: 24),
            const ReviewsSectionTitle(),
            const SizedBox(height: 4),
            ..._placeholderReviews(context),
          ],
        ),
      ),
    );
  }
}

class ReviewsLoadingPlaceholder extends StatelessWidget {
  const ReviewsLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return _LoadingSemantics(
      child: Skeletonizer(
        enabled: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: _placeholderReviews(context),
        ),
      ),
    );
  }
}

class RatingSummaryLoadingPlaceholder extends StatelessWidget {
  const RatingSummaryLoadingPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LoadingSemantics(
      child: Skeletonizer(
        enabled: true,
        child: CourseRatingSummaryCard(stats: _placeholderStats),
      ),
    );
  }
}

class _LoadingSemantics extends StatelessWidget {
  const _LoadingSemantics({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      container: true,
      label: LocaleKeys.loadingReviews,
      child: ExcludeSemantics(child: child),
    );
  }
}

const _placeholderStats = CourseRatingStatsEntity(
  ratingsSum: 52,
  ratingsCount: 12,
);

List<Widget> _placeholderReviews(BuildContext context) {
  const texts = [
    'The lessons are clear and the examples helped me a lot.',
    'Very useful course, I recommend it.',
    'Good explanations and well organized chapters for revision.',
  ];
  final now = DateTime.now();
  final dividerColor = Theme.of(context).brightness == Brightness.dark
      ? Colors.white.withValues(alpha: 0.08)
      : Colors.black.withValues(alpha: 0.08);
  return [
    for (var index = 0; index < texts.length; index++) ...[
      if (index > 0) Divider(height: 1, thickness: 1, color: dividerColor),
      CoursefedbackslistviewItem(
        item: CoursefeedbackItemEntity(
          userImage: '',
          uid: 'placeholder-$index',
          name: 'Student name',
          fedBack: texts[index],
          datePosted: now,
          rating: 5,
        ),
      ),
    ],
  ];
}
