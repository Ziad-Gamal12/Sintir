import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_student_card.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_summary_card.dart';

class ResultsProfileSummary extends StatelessWidget {
  const ResultsProfileSummary(
      {super.key,
      required this.result,
      required this.average,
      required this.count,
      required this.isActive});
  final TestResultEntity result;
  final int average;
  final int count;
  final bool isActive;

  @override
  Widget build(BuildContext context) => Column(children: [
        ResultsStudentCard(result: result, isActive: isActive),
        const SizedBox(height: 16),
        ResultsSummaryCard(average: average, count: count),
      ]);
}
