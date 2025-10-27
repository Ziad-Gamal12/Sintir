import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseSections_SectionWidgets/course_section_item.dart';
import 'package:skeletonizer/skeletonizer.dart';

class LoadingSectionItemsList extends StatelessWidget {
  const LoadingSectionItemsList({
    super.key,
    required this.fakeItems,
    required this.course,
    required this.section,
  });

  final List fakeItems;
  final CourseEntity course;
  final CourseSectionEntity section;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: fakeItems.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Skeletonizer(
          enabled: true,
          child: CourseSectionItem(
            item: fakeItems[index],
            course: course,
            section: section,
          ),
        ),
      ),
    );
  }
}
