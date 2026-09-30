import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseReportsSection.dart';

class CourseDetailsCourseReportsViewBody extends StatelessWidget {
  const CourseDetailsCourseReportsViewBody({super.key, required this.courseId});
  final String courseId;
  @override
  Widget build(BuildContext context) =>
      CourseReportsSection(courseId: courseId);
}
