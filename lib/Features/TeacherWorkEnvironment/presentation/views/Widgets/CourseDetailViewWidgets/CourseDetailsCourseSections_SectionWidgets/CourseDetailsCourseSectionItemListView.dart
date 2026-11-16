import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CustomAddNewCourseSectionItemButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/course_section_items_builder.dart.dart';

class CourseSectionItemList extends StatelessWidget {
  const CourseSectionItemList({
    super.key,
    required this.section,
    required this.course,
    required this.items,
  });

  final CourseSectionEntity section;
  final CourseEntity course;
  final List<dynamic> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAddNewCourseSectionItemButton(
          courseEntity: course,
          section: section,
        ),
        const SizedBox(height: 10),
        CourseSectionItemsBuilder(
          items: items,
          course: course,
          section: section,
        ),
      ],
    );
  }
}
