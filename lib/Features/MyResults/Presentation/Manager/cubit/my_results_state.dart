part of 'my_results_cubit.dart';

@immutable
sealed class MyResultsState {}

final class MyResultsInitial extends MyResultsState {}

final class GetMyResultsSuccess extends MyResultsState {
  final List<TestResultEntity> results;
  final GetMyResultsResponseEntity getMyResultsResponseEntity;
  final int totalCount;
  final int overallAveragePercent;
  final bool hasMore;
  GetMyResultsSuccess(
      {required this.getMyResultsResponseEntity, required this.results})
      : totalCount = getMyResultsResponseEntity.totalCount,
        overallAveragePercent =
            getMyResultsResponseEntity.overallAveragePercent,
        hasMore = getMyResultsResponseEntity.hasMore;
}

final class GetMyResultsFailure extends MyResultsState {
  final String errMessage;
  final List<TestResultEntity> results;
  final int totalCount;
  final int overallAveragePercent;
  final bool hasMore;
  GetMyResultsFailure(
      {required this.errMessage,
      required this.results,
      required this.totalCount,
      required this.overallAveragePercent,
      required this.hasMore});
}

final class GetMyResultsLoading extends MyResultsState {
  final bool isPaginate;
  final List<TestResultEntity> results;
  final int totalCount;
  final int overallAveragePercent;
  final bool hasMore;
  GetMyResultsLoading(
      {required this.isPaginate,
      required this.results,
      required this.totalCount,
      required this.overallAveragePercent,
      required this.hasMore});
}
