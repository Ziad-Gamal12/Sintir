import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';

class ResultDetailsHelper {
  static List<ExamResultSolvedQuestionEntity> getSuccessQuestions(
      TestresulteEntity testresulteEntity) {
    return testresulteEntity.questionsSolvedListEntity
        .where((element) => element.isCorrect == true)
        .toList();
  }

  static double getResultPercent(TestresulteEntity testresulteEntity) {
    return ((getSuccessQuestions(testresulteEntity).length /
                testresulteEntity.totalQuestions) *
            100)
        .toDouble();
  }

  static Color getProgressColor(TestresulteEntity testresulteEntity) {
    double percent = getResultPercent(testresulteEntity);
    if (percent < 50) {
      return Colors.red;
    } else if (percent < 75) {
      return Colors.yellow.shade500;
    } else {
      return Colors.green;
    }
  }
}
