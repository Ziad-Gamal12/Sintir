import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsListViewItem.dart';

class CourseDetailsCourseReportsListView extends StatelessWidget {
  const CourseDetailsCourseReportsListView({super.key, required this.reports});
  final List<CourseReportEntity> reports;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) => CourseDetailsCourseReportsListViewItem(
        report: reports[index],
      ),
    );
  }
}
