import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CoursedetailsreportListViewitem.dart';

class Coursedetailsreportlistview extends StatelessWidget {
  const Coursedetailsreportlistview({super.key, required this.reports});
  final List<Coursereportsitementity> reports;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: reports.length,
      itemBuilder: (context, index) => Coursedetailsreportlistviewitem(
        report: reports[index],
      ),
    );
  }
}
