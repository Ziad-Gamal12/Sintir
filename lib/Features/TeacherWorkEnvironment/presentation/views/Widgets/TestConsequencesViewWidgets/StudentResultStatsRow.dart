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
    final percent = ResultDetailsHelper.getResultPercent(testResultEntity)
        .toStringAsFixed(2);
    final score =
        "${ResultDetailsHelper.getSuccessQuestions(testResultEntity).length}/${testResultEntity.totalQuestions}";

    return Row(
      children: [
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsGraphBar,
            title: "نسبة التقييم",
            value: "$percent%",
            backgroundColor: Colors.blue.shade50,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsMisionIcon,
            title: "درجة الطالب",
            value: score,
            backgroundColor: Colors.green.shade50,
          ),
        ),
      ],
    );
  }
}
