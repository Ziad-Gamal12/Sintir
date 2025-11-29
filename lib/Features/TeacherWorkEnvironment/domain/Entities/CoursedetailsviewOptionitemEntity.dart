import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseDetailsCouponsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscribersReviewsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersView.dart';
import 'package:sintir/locale_keys.dart';

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
        title: LocaleKeys.content,
        image: Assets.assetsIconsContentManagement,
        description: LocaleKeys.contentDescription,
        onTap: () {
          GoRouter.of(context)
              .push(CourseDetailsCourseSectionsView.routeName, extra: course);
        },
      ),
      CoursedetailsviewOptionitemEntity(
        title: LocaleKeys.students,
        image: Assets.assetsImagesStudents,
        description: LocaleKeys.studentsDescription,
        onTap: () {
          GoRouter.of(context)
              .push(CourseDetailsSubscribersView.routeName, extra: course);
        },
      ),
      CoursedetailsviewOptionitemEntity(
        title: LocaleKeys.studentsReviews,
        image: Assets.assetsIconsFeedback,
        description: LocaleKeys.studentsReviewsDescription,
        onTap: () {
          GoRouter.of(context).push(
              CourseDetailsSubscribersReviewsView.routeName,
              extra: course.id);
        },
      ),
      CoursedetailsviewOptionitemEntity(
        title: LocaleKeys.coupons,
        image: Assets.assetsIconsCoupon,
        description: LocaleKeys.couponsDescription,
        onTap: () {
          GoRouter.of(context)
              .push(CourseDetailsCouponsView.routeName, extra: course.id);
        },
      ),
      CoursedetailsviewOptionitemEntity(
        title: LocaleKeys.reports,
        image: Assets.assetsIconsComplain,
        description: LocaleKeys.reportsDescription,
        onTap: () {
          GoRouter.of(context)
              .push(CourseDetailsCourseReportsView.routeName, extra: course.id);
        },
      ),
    ];
  }
}
