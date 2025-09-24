// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomCourseSectionsListViewItem.dart';

class CustomCourseDetailsBodyCourseSections_SliverList extends StatelessWidget {
  const CustomCourseDetailsBodyCourseSections_SliverList({
    super.key,
    required this.courseSections,
    required this.course,
  });

  final List<CourseSectionEntity> courseSections;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: courseSections.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CustomCourseDetailsSectionsListViewitem(
            course: course,
            sectionItem: courseSections[index],
          ),
        );
      },
    );
  }
}
