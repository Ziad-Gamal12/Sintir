import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportDetailsContent.dart';

class ReportDetailsPanel extends StatelessWidget {
  const ReportDetailsPanel(
      {super.key, required this.courseId, required this.reportId});
  final String courseId, reportId;
  @override
  Widget build(BuildContext context) => Card(
        margin: EdgeInsets.zero,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Theme.of(context).dividerColor)),
        child: ReportDetailsContent(courseId: courseId, reportId: reportId),
      );
}
