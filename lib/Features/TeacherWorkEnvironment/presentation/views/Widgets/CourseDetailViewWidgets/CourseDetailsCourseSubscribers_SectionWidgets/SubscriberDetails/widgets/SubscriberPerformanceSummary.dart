import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/results/results_status_mapper.dart';

class SubscriberPerformanceSummary {
  const SubscriberPerformanceSummary({
    required this.highest,
    required this.lowest,
    required this.average,
    required this.chronologicalResults,
    required this.normalizedScores,
    required this.percentages,
    required this.resultDiscrepancyCount,
  });

  final TestResultEntity? highest;
  final TestResultEntity? lowest;
  final double average;
  final List<TestResultEntity> chronologicalResults;
  final List<double> normalizedScores;
  final List<int> percentages;
  final int resultDiscrepancyCount;

  int? get trendDelta => percentages.length < 2
      ? null
      : percentages.last - percentages[percentages.length - 2];

  factory SubscriberPerformanceSummary.fromResults(
    List<TestResultEntity> results,
  ) {
    final chronological = List<TestResultEntity>.of(results)
      ..sort((a, b) => a.joinedDate.compareTo(b.joinedDate));
    final percentages = chronological
        .map(ResultsStatusMapper.percentage)
        .toList(growable: false);
    final scores = percentages.map((value) => value / 100).toList();
    final indexed = List<int>.generate(percentages.length, (i) => i);
    final discrepancyCount = chronological
        .where((result) =>
            result.result !=
            result.questionsSolvedListEntity
                .where((question) => question.isCorrect)
                .length)
        .length;
    if (indexed.isEmpty) {
      return const SubscriberPerformanceSummary(
        highest: null,
        lowest: null,
        average: 0,
        chronologicalResults: [],
        normalizedScores: [],
        percentages: [],
        resultDiscrepancyCount: 0,
      );
    }
    indexed.sort((a, b) => percentages[a].compareTo(percentages[b]));
    return SubscriberPerformanceSummary(
      highest: chronological[indexed.last],
      lowest: chronological[indexed.first],
      average: percentages.reduce((a, b) => a + b) / percentages.length,
      chronologicalResults: List.unmodifiable(chronological),
      normalizedScores: List.unmodifiable(scores),
      percentages: List.unmodifiable(percentages),
      resultDiscrepancyCount: discrepancyCount,
    );
  }
}
