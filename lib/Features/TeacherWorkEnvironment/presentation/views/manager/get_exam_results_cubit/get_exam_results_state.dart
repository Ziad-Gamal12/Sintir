part of 'get_exam_results_cubit.dart';

@immutable
sealed class GetExamResultsState {}

final class GetExamResultsInitial extends GetExamResultsState {}

final class GetExamResultsLoading extends GetExamResultsState {
  final bool isPaginate;

  GetExamResultsLoading({required this.isPaginate});
}

final class GetExamResultsSuccess extends GetExamResultsState {
  final GetExamResultsReponseEntity getExamResultsReponseEntity;

  GetExamResultsSuccess({required this.getExamResultsReponseEntity});
}

final class GetExamResultsFailure extends GetExamResultsState {
  final String errmessage;
  GetExamResultsFailure({required this.errmessage});
}
