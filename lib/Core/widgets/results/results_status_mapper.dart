import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Core/widgets/results/results_tokens.dart';

class ResultsStatus {
  const ResultsStatus(this.label, this.color, this.icon);
  final String label;
  final Color color;
  final IconData icon;
}

enum ResultsPerformanceTier { excellent, good, steady, followUp }

class ResultsStatusMapper {
  static const excellentThreshold = 85;
  static const goodThreshold = 65;
  static const steadyThreshold = 50;

  static ResultsPerformanceTier performanceTier(double value) {
    if (value >= excellentThreshold) return ResultsPerformanceTier.excellent;
    if (value >= goodThreshold) return ResultsPerformanceTier.good;
    if (value >= steadyThreshold) return ResultsPerformanceTier.steady;
    return ResultsPerformanceTier.followUp;
  }

  static int percentage(TestResultEntity result) {
    if (result.totalQuestions <= 0) return 0;
    final correct = result.questionsSolvedListEntity
        .where((question) => question.isCorrect)
        .length;
    return (correct * 100 / result.totalQuestions)
        .round()
        .clamp(0, 100)
        .toInt();
  }

  static ResultsStatus average(double value, ThemeData theme) {
    final tokens = ResultsTokens.of(theme);
    switch (performanceTier(value)) {
      case ResultsPerformanceTier.excellent:
        return ResultsStatus(LocaleKeys.resultsExcellent, tokens.success,
            Icons.verified_rounded);
      case ResultsPerformanceTier.good:
        return ResultsStatus(
            LocaleKeys.resultsGood, tokens.primary, Icons.trending_up_rounded);
      case ResultsPerformanceTier.steady:
        return ResultsStatus(LocaleKeys.resultsSteady, tokens.warning,
            Icons.trending_flat_rounded);
      case ResultsPerformanceTier.followUp:
        return ResultsStatus(LocaleKeys.resultsFollowUp, tokens.failure,
            Icons.warning_amber_rounded);
    }
  }

  static ResultsStatus assessment(int value, ThemeData theme) {
    final tokens = ResultsTokens.of(theme);
    if (value >= 100) {
      return ResultsStatus(LocaleKeys.resultsFullyComplete, tokens.success,
          Icons.check_circle_rounded);
    }
    if (value > 0) {
      return ResultsStatus(LocaleKeys.resultsPartiallyComplete, tokens.primary,
          Icons.timelapse_rounded);
    }
    return ResultsStatus(
        LocaleKeys.resultsRecorded, tokens.muted, Icons.receipt_long_rounded);
  }
}
