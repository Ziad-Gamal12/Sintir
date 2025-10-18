import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetailsHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentStatItem.dart';

class StudentResultStatsRow extends StatelessWidget {
  const StudentResultStatsRow({super.key, required this.testResultEntity});
  final TestResultEntity testResultEntity;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsGraphBar,
            value:
                "${ResultDetailsHelper.getResultPercent(testResultEntity).toStringAsFixed(2)} %",
            title: "نسبة التقييم",
            backgroundColor: Colors.lightBlue.shade100,
          ),
        ),
        Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              width: 1,
              height: 50,
              color: Colors.grey.shade300,
            )),
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsMisionIcon,
            value:
                "${ResultDetailsHelper.getSuccessQuestions(testResultEntity).length}/${testResultEntity.totalQuestions}",
            title: "درجة الطالب",
            backgroundColor: Colors.lightBlue.shade100,
          ),
        ),
      ],
    );
  }

  double getResultPercentage(int correctAnswers, int totalQuestions) {
    if (totalQuestions == 0) {
      return 0.0;
    }
    return (correctAnswers / totalQuestions) * 100;
  }
}
