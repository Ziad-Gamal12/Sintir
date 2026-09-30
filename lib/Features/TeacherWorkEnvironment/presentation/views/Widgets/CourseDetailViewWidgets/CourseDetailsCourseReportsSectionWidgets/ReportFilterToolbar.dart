import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportSortButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/ReportTypeFilterButton.dart';

class ReportFilterToolbar extends StatelessWidget {
  const ReportFilterToolbar({super.key, required this.isMobile});
  final bool isMobile;
  @override
  Widget build(BuildContext context) => Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          spacing: 8,
          children: [
            ReportTypeFilterButton(isMobile: isMobile),
            ReportSortButton(isMobile: isMobile),
          ]);
}
