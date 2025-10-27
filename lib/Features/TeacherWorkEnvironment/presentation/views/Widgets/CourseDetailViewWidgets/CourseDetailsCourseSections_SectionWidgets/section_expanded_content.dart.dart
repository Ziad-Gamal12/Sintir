import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/CourseDetailsCourseSectionItemListView.dart';

class SectionExpandedContent extends StatelessWidget {
  const SectionExpandedContent({
    super.key,
    required this.sectionItem,
    required this.sectionLessons,
    required this.course,
  });

  final CourseSectionEntity sectionItem;
  final List<dynamic> sectionLessons;
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
      ),
      child: CourseSectionItemList(
        section: sectionItem,
        items: sectionLessons,
        course: course,
      ),
    );
  }
}
