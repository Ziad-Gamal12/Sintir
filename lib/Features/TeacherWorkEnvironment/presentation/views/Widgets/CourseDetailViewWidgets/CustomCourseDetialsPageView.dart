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
    required this.scrollController,
  });

  final PageController pageController;
  final ScrollController scrollController;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          CourseDetailsCourseSectionsPageViewItem(
            courseEntity: course,
            scrollController: scrollController,
          ),
          CourseDetailsSubscribersPageViewItem(
            scrollController: scrollController,
          ),
          CourseDetailsSubscribersReviewsPageViewItem(
            courseId: course.id,
            scrollController: scrollController,
          ),
          CourseDetailsCourseReportsPageViewItem(
            courseId: course.id,
            scrollController: scrollController,
          ),
        ]);
  }
}
