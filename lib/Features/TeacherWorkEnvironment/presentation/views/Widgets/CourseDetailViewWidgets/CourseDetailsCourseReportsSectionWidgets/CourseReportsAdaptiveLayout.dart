import 'package:flutter/material.dart';
import 'package:sintir/Core/Managers/Cubits/CourseReportsCubit/course_reports_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseReportsMobileLayout.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseReportsTabletLayout.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/utils/report_breakpoints.dart';

class CourseReportsAdaptiveLayout extends StatelessWidget {
  const CourseReportsAdaptiveLayout(
      {super.key,
      required this.courseId,
      required this.width,
      required this.state});
  final String courseId;
  final double width;
  final CourseReportsState state;
  @override
  Widget build(BuildContext context) {
    final content = width < ReportBreakpoints.mobile
        ? CourseReportsMobileLayout(courseId: courseId, state: state)
        : CourseReportsTabletLayout(
            courseId: courseId, width: width, state: state);
    return Center(
        child: ConstrainedBox(
            constraints: const BoxConstraints(
                maxWidth: ReportBreakpoints.maxContentWidth),
            child: content));
  }
}
