// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCourseReportsSectionWidgets/CourseDetailsCourseReportsListViewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseDetailsCourseLoadingReportsListView extends StatelessWidget {
  CourseDetailsCourseLoadingReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Skeletonizer(
          enabled: true,
          child: CourseDetailsCourseReportsListViewItem(
            report: reports[index],
          ),
        ),
      ),
    );
  }

  List<CourseReportEntity> reports =
      List.generate(6, (index) => CourseReportEntity.empty());
}
