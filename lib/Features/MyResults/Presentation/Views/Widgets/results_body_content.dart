import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Presentation/Manager/cubit/my_results_cubit.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_adaptive_layout.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_empty.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_error.dart';
import 'package:sintir/Features/MyResults/Presentation/Views/Widgets/results_loading.dart';

class ResultsBodyContent extends StatelessWidget {
  const ResultsBodyContent(
      {super.key,
      required this.state,
      required this.isActive,
      required this.scrollController,
      required this.onRefresh});
  final MyResultsState state;
  final bool isActive;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    final results = switch (state) {
      GetMyResultsSuccess(:final results) => results,
      GetMyResultsLoading(:final results) => results,
      GetMyResultsFailure(:final results) => results,
      _ => const <TestResultEntity>[],
    };
    if (state is GetMyResultsFailure && results.isEmpty) {
      return ResultsError(onRetry: onRefresh);
    }
    if (state is GetMyResultsLoading && results.isEmpty) {
      return const ResultsLoading();
    }
    if (state is GetMyResultsSuccess && results.isEmpty) {
      return const ResultsEmpty();
    }
    if (results.isEmpty) return const ResultsLoading();
    return ResultsAdaptiveLayout(
      results: results,
      average: switch (state) {
        GetMyResultsSuccess(:final overallAveragePercent) =>
          overallAveragePercent,
        GetMyResultsLoading(:final overallAveragePercent) =>
          overallAveragePercent,
        GetMyResultsFailure(:final overallAveragePercent) =>
          overallAveragePercent,
        _ => 0,
      },
      totalCount: switch (state) {
        GetMyResultsSuccess(:final totalCount) => totalCount,
        GetMyResultsLoading(:final totalCount) => totalCount,
        GetMyResultsFailure(:final totalCount) => totalCount,
        _ => results.length,
      },
      hasMore: switch (state) {
        GetMyResultsSuccess(:final hasMore) => hasMore,
        GetMyResultsLoading(:final hasMore) => hasMore,
        GetMyResultsFailure(:final hasMore) => hasMore,
        _ => false,
      },
      isActive: isActive,
      scrollController: scrollController,
      onRefresh: onRefresh,
      isLoadingMore: state is GetMyResultsLoading &&
          (state as GetMyResultsLoading).isPaginate,
    );
  }
}
