import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';

class SubscriberPerformanceSummary {
  const SubscriberPerformanceSummary({
    required this.highest,
    required this.lowest,
    required this.average,
    required this.normalizedScores,
  });

  final TestResultEntity? highest;
  final TestResultEntity? lowest;
  final double average;
  final List<double> normalizedScores;

  factory SubscriberPerformanceSummary.fromResults(
    List<TestResultEntity> results,
  ) {
    final scores = results.map(_normalizedScore).toList(growable: false);
    final finiteScores = scores.where((score) => score.isFinite).toList();
    return SubscriberPerformanceSummary(
      highest: results.isEmpty
          ? null
          : results.reduce(
              (a, b) => _normalizedScore(a) >= _normalizedScore(b) ? a : b),
      lowest: results.isEmpty
          ? null
          : results.reduce(
              (a, b) => _normalizedScore(a) <= _normalizedScore(b) ? a : b),
      average: finiteScores.isEmpty
          ? 0
          : finiteScores.reduce((a, b) => a + b) / finiteScores.length,
      normalizedScores: scores,
    );
  }

  static double _normalizedScore(TestResultEntity result) {
    if (result.totalQuestions <= 0) return 0;
    final score = result.result / result.totalQuestions;
    if (!score.isFinite) return 0;
    return score.clamp(0, 1).toDouble();
  }
}
