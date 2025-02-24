import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/Coursedetailsreportlistview.dart';

class Coursedetailsreportspageviewitem extends StatelessWidget {
  const Coursedetailsreportspageviewitem({super.key, required this.reports});
  final List<Coursereportsitementity> reports;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        reports.isEmpty
            ? const CustomEmptyWidget()
            : Coursedetailsreportlistview(
                reports: reports,
              )
      ],
    );
  }
}
