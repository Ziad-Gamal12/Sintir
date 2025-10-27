import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/course_section_item.dart';

class SectionItemsList extends StatelessWidget {
  const SectionItemsList({
    super.key,
    required this.items,
    required this.course,
    required this.section,
  });

  final List<dynamic> items;
  final CourseEntity course;
  final CourseSectionEntity section;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: CourseSectionItem(
          item: items[index],
          course: course,
          section: section,
        ),
      ),
    );
  }
}
