part of 'get_user_pervious_results_of_exam_cubit.dart';

@immutable
sealed class GetUserPerviousResultsOfExamState {}

final class GetUserPerviousResultsOfExamInitial
    extends GetUserPerviousResultsOfExamState {}

final class GetUserPerviousResultsOfExamLoading
    extends GetUserPerviousResultsOfExamState {}

final class GetUserPerviousResultsOfExamSuccess
    extends GetUserPerviousResultsOfExamState {
  final List<TestResultEntity> resultsOfExamsList;
  GetUserPerviousResultsOfExamSuccess({required this.resultsOfExamsList});
}

final class GetUserPerviousResultsOfExamFailure
    extends GetUserPerviousResultsOfExamState {
  final String errMessage;
  GetUserPerviousResultsOfExamFailure({required this.errMessage});
}
