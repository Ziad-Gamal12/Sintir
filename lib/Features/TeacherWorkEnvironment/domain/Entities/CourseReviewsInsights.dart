// ignore_for_file: file_names

import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

enum CourseReviewsTrend { up, down, steady, unknown }

class CourseReviewsInsights {
  const CourseReviewsInsights({
    required this.recentRatingsCount,
    required this.recentAverage,
    required this.trend,
    this.newCount,
    this.newCountIsPartial = false,
  });

  static const Duration recentWindow = Duration(days: 30);
  static const Duration maxLookBack = Duration(days: 90);
  static const int minRatingsForTrend = 3;
  static const double trendThreshold = 0.1;

  final int recentRatingsCount;
  final double recentAverage;
  final CourseReviewsTrend trend;
  final int? newCount;
  final bool newCountIsPartial;

  bool get hasRecentRatings => recentRatingsCount > 0;

  static DateTime fetchSince({required DateTime now, DateTime? lastSeen}) {
    final recentStart = now.subtract(recentWindow);
    if (lastSeen == null || !lastSeen.isBefore(recentStart)) {
      return recentStart;
    }
    final oldest = now.subtract(maxLookBack);
    return lastSeen.isBefore(oldest) ? oldest : lastSeen;
  }

  factory CourseReviewsInsights.compute({
    required List<CoursefeedbackItemEntity> reviews,
    required bool isComplete,
    required double overallAverage,
    required DateTime now,
    DateTime? lastSeen,
  }) {
    final recentStart = now.subtract(recentWindow);
    var count = 0;
    var sum = 0;
    var newCount = 0;
    for (final review in reviews) {
      final rating = review.rating;
      if (rating != null && !review.datePosted.isBefore(recentStart)) {
        count++;
        sum += rating;
      }
      if (lastSeen != null && review.datePosted.isAfter(lastSeen)) {
        newCount++;
      }
    }
    final average = count == 0 ? 0.0 : sum / count;
    final lookBackStart = now.subtract(maxLookBack);
    return CourseReviewsInsights(
      recentRatingsCount: count,
      recentAverage: average,
      trend: _trend(count, average, overallAverage),
      newCount: lastSeen == null ? null : newCount,
      newCountIsPartial:
          lastSeen != null &&
          (!isComplete || lastSeen.isBefore(lookBackStart)),
    );
  }

  static CourseReviewsTrend _trend(int count, double recent, double overall) {
    if (count < minRatingsForTrend || overall <= 0) {
      return CourseReviewsTrend.unknown;
    }
    final difference = ((recent - overall) * 100).round();
    final threshold = (trendThreshold * 100).round();
    if (difference >= threshold) return CourseReviewsTrend.up;
    if (difference <= -threshold) return CourseReviewsTrend.down;
    return CourseReviewsTrend.steady;
  }
}
