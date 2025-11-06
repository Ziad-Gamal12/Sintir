part of 'my_results_cubit.dart';

@immutable
sealed class MyResultsState {}

final class MyResultsInitial extends MyResultsState {}

final class GetMyResultsSuccess extends MyResultsState {
  final GetMyResultsResponseEntity getMyResultsResponseEntity;
  GetMyResultsSuccess({required this.getMyResultsResponseEntity});
}

final class GetMyResultsFailure extends MyResultsState {
  final String errMessage;
  GetMyResultsFailure({required this.errMessage});
}

final class GetMyResultsLoading extends MyResultsState {
  final bool isPaginate;
  GetMyResultsLoading({required this.isPaginate});
}
