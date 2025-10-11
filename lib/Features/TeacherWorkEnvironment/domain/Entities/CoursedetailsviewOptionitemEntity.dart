import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscribersReviewsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersView.dart';

class CoursedetailsviewOptionitemEntity {
  final String title;
  final String image;
  final String description;
  final VoidCallback onTap;
  CoursedetailsviewOptionitemEntity({
    required this.title,
    required this.image,
    required this.onTap,
    required this.description,
  });
  static List<CoursedetailsviewOptionitemEntity> toList(
      {required BuildContext context, required CourseEntity course}) {
    return [
      CoursedetailsviewOptionitemEntity(
        title: "المحتوى",
        image: Assets.assetsIconsContentManagement,
        description: "استعرض دروس واختبارات الكورس بشكل منظم وسهل خطوة بخطوة.",
        onTap: () {
          GoRouter.of(context)
              .push(CourseDetailsCourseSectionsView.routeName, extra: course);
        },
      ),
      CoursedetailsviewOptionitemEntity(
          description:
              "تعرف على الطلاب المشتركين في هذا الكورس وتابع تقدمهم بسهولة.",
          onTap: () {
            GoRouter.of(context).push(
              CourseDetailsSubscribersView.routeName,
              extra: course,
            );
          },
          title: "الطلاب",
          image: Assets.assetsImagesStudents),
      CoursedetailsviewOptionitemEntity(
          description:
              "اقرأ آراء الطلاب وتقييماتهم حول الكورس لتحصل على فكرة أوضح عن التجربة التعليمية.",
          onTap: () {
            GoRouter.of(context).push(
                CourseDetailsSubscribersReviewsView.routeName,
                extra: course.id);
          },
          title: "أراء الطلاب",
          image: Assets.assetsIconsFeedback),
      CoursedetailsviewOptionitemEntity(
          description:
              "راقب أداء الكورس من خلال تقارير مفصلة توضح التقدم والتفاعل والنتائج.",
          onTap: () {
            GoRouter.of(context).push(CourseDetailsCourseReportsView.routeName,
                extra: course.id);
          },
          title: "الأبلاغات",
          image: Assets.assetsIconsComplain),
    ];
  }
}
