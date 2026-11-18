// ignore_for_file: file_names

import 'dart:math' as math;

import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherAttentionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseState.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherEarningsPolicy.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWorkspaceKpis.dart';

class TeacherWorkspaceSummary {
  const TeacherWorkspaceSummary({
    required this.kpis,
    required this.attention,
    required this.openReportsByCourse,
  });

  static const Duration activityWindow = Duration(days: 30);
  static const Duration firstVisitReviewsWindow = Duration(days: 14);
  static const int couponDaysThreshold = 3;
  static const int lowRatingMax = 2;

  final TeacherWorkspaceKpis kpis;
  final List<TeacherAttentionItem> attention;
  final Map<String, int> openReportsByCourse;

  int openReportsFor(String courseId) => openReportsByCourse[courseId] ?? 0;

  factory TeacherWorkspaceSummary.build({
    required List<CourseEntity> courses,
    required List<TeacherCourseActivity> activities,
    required DateTime now,
  }) {
    final byCourse = {
      for (final activity in activities) activity.courseId: activity,
    };
    var newStudents = 0;
    var previousNewStudents = 0;
    var netEarnings = 0.0;
    var ratingsSum = 0;
    var ratingsCount = 0;
    var totalStudents = 0;
    var publishedCourses = 0;
    final openReports = <String, int>{};
    final buckets = {
      for (final kind in TeacherAttentionKind.values)
        kind: <TeacherAttentionItem>[],
    };

    for (final course in courses) {
      if (course.id == CourseEntity.loadingId) continue;
      final state = TeacherCourseState.fromRaw(course.state);
      totalStudents += course.studentsCount;
      ratingsSum += course.ratingStats.ratingsSum;
      ratingsCount += course.ratingStats.ratingsCount;
      if (state == TeacherCourseState.published) publishedCourses++;
      if (state == TeacherCourseState.declined) {
        buckets[TeacherAttentionKind.declined]!.add(
          TeacherAttentionItem.declined(course),
        );
      } else if (state == TeacherCourseState.hiddenByAdmin ||
          state == TeacherCourseState.removedByAdmin) {
        buckets[TeacherAttentionKind.adminHidden]!.add(
          TeacherAttentionItem.adminHidden(course),
        );
      }

      final activity = byCourse[course.id];
      if (activity == null) continue;
      newStudents += activity.newStudents;
      previousNewStudents += activity.previousNewStudents;
      netEarnings += TeacherEarningsPolicy.netFromGross(activity.grossRevenue);

      if (activity.openReports > 0) {
        openReports[course.id] = activity.openReports;
        buckets[TeacherAttentionKind.openReports]!.add(
          TeacherAttentionItem.openReports(course, activity.openReports),
        );
      }

      final lowRatings = lowRatingsOf(activity.recentReviews);
      if (lowRatings.isNotEmpty) {
        buckets[TeacherAttentionKind.lowRatings]!.add(
          TeacherAttentionItem.lowRatings(
            course,
            lowRatings.first,
            lowRatings.length,
          ),
        );
      }

      for (final coupon in activity.coupons) {
        if (!isCouponEnding(coupon, now)) continue;
        final daysLeft = couponDaysLeft(coupon, now);
        buckets[TeacherAttentionKind.couponEnding]!.add(
          TeacherAttentionItem.couponEnding(
            course,
            coupon,
            daysLeft: daysLeft <= couponDaysThreshold ? daysLeft : null,
          ),
        );
      }
    }

    return TeacherWorkspaceSummary(
      kpis: TeacherWorkspaceKpis(
        newStudents: newStudents,
        previousNewStudents: previousNewStudents,
        netEarnings: (netEarnings * 100).roundToDouble() / 100,
        ratingsSum: ratingsSum,
        ratingsCount: ratingsCount,
        totalStudents: totalStudents,
        publishedCourses: publishedCourses,
      ),
      attention: List.unmodifiable([
        for (final kind in TeacherAttentionKind.values) ...buckets[kind]!,
      ]),
      openReportsByCourse: Map.unmodifiable(openReports),
    );
  }

  static List<CoursefeedbackItemEntity> lowRatingsOf(
    List<CoursefeedbackItemEntity> reviews,
  ) {
    final low = [
      for (final review in reviews)
        if ((review.rating ?? lowRatingMax + 1) <= lowRatingMax) review,
    ];
    low.sort((a, b) => b.datePosted.compareTo(a.datePosted));
    return low;
  }

  static int couponDaysLeft(CourseCouponEntity coupon, DateTime now) {
    final today = DateTime.utc(now.year, now.month, now.day);
    final expiry = DateTime.utc(
      coupon.expiryDate.year,
      coupon.expiryDate.month,
      coupon.expiryDate.day,
    );
    return expiry.difference(today).inDays;
  }

  static bool isCouponEnding(CourseCouponEntity coupon, DateTime now) {
    if (!coupon.isManuallyEnabled || coupon.hasReachedUsageLimit) return false;
    final daysLeft = couponDaysLeft(coupon, now);
    if (daysLeft < 0) return false;
    if (daysLeft <= couponDaysThreshold) return true;
    if (coupon.usageLimit <= 0) return false;
    final remaining = coupon.usageLimit - coupon.usedCount;
    final threshold = math.max(2, (coupon.usageLimit * 0.1).ceil());
    return remaining <= threshold;
  }
}
