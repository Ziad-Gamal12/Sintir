import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';

class ResultDetailsHelper {
  static List<ExamResultSolvedQuestionEntity> getSuccessQuestions(
      TestResultEntity testresulteEntity) {
    return testresulteEntity.questionsSolvedListEntity
        .where((element) => element.isCorrect == true)
        .toList();
  }

  static double getResultPercent(TestResultEntity testresulteEntity) {
    if (testresulteEntity.totalQuestions <= 0) return 0;
    final percent = getSuccessQuestions(testresulteEntity).length /
        testresulteEntity.totalQuestions *
        100;
    return percent.isFinite ? percent : 0;
  }

  static Color getProgressColor(TestResultEntity testresulteEntity) {
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
