import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsPageViewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReviewsSectionWidgets/CourseDetailsSubscripersReviewsPageViewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionsPageViewItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSubscribers_SectionWidgets/CourseDetailsSubscribersPageViewItem.dart';

class CustomCourseDetialsPageView extends StatelessWidget {
  const CustomCourseDetialsPageView({
    super.key,
    required this.pageController,
    required this.course,
    required this.isFechedCourseSectoins,
    required this.isFechedCourseSubscripers,
    required this.isFechedCourseFeedBacks,
    required this.isFechedCourseReports,
  });

  final PageController pageController;
  final CourseEntity course;
  final bool isFechedCourseSectoins;
  final bool isFechedCourseSubscripers;
  final bool isFechedCourseFeedBacks;
  final bool isFechedCourseReports;

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CourseDetailsCourseSectionsPageViewItem(
            courseEntity: course,
            isFetchedCourseSections: isFechedCourseSectoins,
          ),
          CourseDetailsSubscribersPageViewItem(
            isFetchedCourseSubscribers: isFechedCourseSubscripers,
          ),
          CourseDetailsSubscripersReviewsPageViewItem(
            courseId: course.id,
            isFetchedCourseFeedBacks: isFechedCourseFeedBacks,
          ),
          CourseDetailsCourseReportsPageViewItem(
            courseId: course.id,
            isFetchedCourseReports: isFechedCourseReports,
          ),
        ]);
  }
}
