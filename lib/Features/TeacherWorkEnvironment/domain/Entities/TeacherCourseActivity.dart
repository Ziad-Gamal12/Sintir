// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

class TeacherCourseActivity {
  const TeacherCourseActivity({
    required this.courseId,
    this.newStudents = 0,
    this.previousNewStudents = 0,
    this.grossRevenue = 0,
    this.openReports = 0,
    this.recentReviews = const [],
    this.coupons = const [],
  });

  final String courseId;
  final int newStudents;
  final int previousNewStudents;
  final double grossRevenue;
  final int openReports;
  final List<CoursefeedbackItemEntity> recentReviews;
  final List<CourseCouponEntity> coupons;
}
