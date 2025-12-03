import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseInfoSectionWidgets/custom_course_details_body_course_info_header.dart';

import 'CustomCourseDetailsBodyCourseInfoTexts.dart';

class CustomCourseDetailsBodyCourseInfoCard extends StatelessWidget {
  const CustomCourseDetailsBodyCourseInfoCard({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      color: theme.cardColor, // يعتمد على الثيم (Light / Dark)
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCourseDetailsBodyCourseInfoHeader(courseEntity: courseEntity),
            CustomCourseDetailsBodyCourseInfoTexts(courseEntity: courseEntity),
          ],
        ),
      ),
    );
  }
}
