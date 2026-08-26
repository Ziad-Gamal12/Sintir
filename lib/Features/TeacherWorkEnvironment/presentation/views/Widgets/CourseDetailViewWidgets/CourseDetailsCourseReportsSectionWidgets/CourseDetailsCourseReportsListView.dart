import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsListViewItem.dart';
import 'package:sintir/constant.dart';

class CourseDetailsCourseReportsListView extends StatelessWidget {
  const CourseDetailsCourseReportsListView(
      {super.key, required this.reports, required this.scrollController});
  final List<CourseReportEntity> reports;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(
          vertical: KVerticalPadding, horizontal: KHorizontalPadding),
      controller: scrollController,
      itemCount: reports.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: CourseDetailsCourseReportsListViewItem(
          report: reports[index],
        ),
      ),
    );
  }
}
