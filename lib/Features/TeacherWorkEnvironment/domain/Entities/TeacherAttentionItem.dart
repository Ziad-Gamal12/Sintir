// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

enum TeacherAttentionKind {
  declined,
  adminHidden,
  openReports,
  lowRatings,
  couponEnding,
}

class TeacherAttentionItem {
  const TeacherAttentionItem._({
    required this.kind,
    required this.course,
    this.count = 1,
    this.review,
    this.coupon,
    this.couponDaysLeft,
  });

  factory TeacherAttentionItem.declined(CourseEntity course) =>
      TeacherAttentionItem._(
        kind: TeacherAttentionKind.declined,
        course: course,
      );

  factory TeacherAttentionItem.adminHidden(CourseEntity course) =>
      TeacherAttentionItem._(
        kind: TeacherAttentionKind.adminHidden,
        course: course,
      );

  factory TeacherAttentionItem.openReports(CourseEntity course, int count) =>
      TeacherAttentionItem._(
        kind: TeacherAttentionKind.openReports,
        course: course,
        count: count,
      );

  factory TeacherAttentionItem.lowRatings(
    CourseEntity course,
    CoursefeedbackItemEntity latest,
    int count,
  ) => TeacherAttentionItem._(
    kind: TeacherAttentionKind.lowRatings,
    course: course,
    count: count,
    review: latest,
  );

  factory TeacherAttentionItem.couponEnding(
    CourseEntity course,
    CourseCouponEntity coupon, {
    int? daysLeft,
  }) => TeacherAttentionItem._(
    kind: TeacherAttentionKind.couponEnding,
    course: course,
    coupon: coupon,
    couponDaysLeft: daysLeft,
  );

  final TeacherAttentionKind kind;
  final CourseEntity course;
  final int count;
  final CoursefeedbackItemEntity? review;
  final CourseCouponEntity? coupon;
  final int? couponDaysLeft;

  String get id => '${kind.name}|${course.id}|${coupon?.code ?? ''}';
}
