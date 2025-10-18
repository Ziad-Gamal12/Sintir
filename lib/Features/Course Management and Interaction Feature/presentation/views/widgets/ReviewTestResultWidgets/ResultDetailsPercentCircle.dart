import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetailsHelper.dart';

class ResultDetailsPercentCircle extends StatelessWidget {
  const ResultDetailsPercentCircle(
      {super.key, required this.testresulteEntity});
  final TestResultEntity testresulteEntity;

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 80,
      lineWidth: 13.0,
      animation: true,
      animationDuration: 1200,
      backgroundColor: Colors.grey.shade300,
      percent:
          (ResultDetailsHelper.getSuccessQuestions(testresulteEntity).length /
              testresulteEntity.totalQuestions),
      center: Text(
        "${ResultDetailsHelper.getResultPercent(testresulteEntity).toStringAsFixed(2)} %",
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
      ),
      progressColor: ResultDetailsHelper.getProgressColor(testresulteEntity),
      circularStrokeCap: CircularStrokeCap.round,
    );
  }
}
