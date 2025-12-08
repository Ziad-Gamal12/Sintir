part of 'TestOverViewCubit.dart';

@immutable
sealed class TestOverViewState {}

final class GetUserPerviousResultsOfExamInitial extends TestOverViewState {}

final class GetUserPerviousResultsOfExamLoading extends TestOverViewState {}

final class GetUserPerviousResultsOfExamSuccess extends TestOverViewState {
  final List<TestResultEntity> resultsOfExamsList;
  GetUserPerviousResultsOfExamSuccess({required this.resultsOfExamsList});
}

final class GetUserPerviousResultsOfExamFailure extends TestOverViewState {
  final String errMessage;
  GetUserPerviousResultsOfExamFailure({required this.errMessage});
}

// hasReachedMaxAttempts
final class HasReachedMaxAttemptsLoading extends TestOverViewState {}

final class HasReachedMaxAttemptsSuccess extends TestOverViewState {
  final bool hasReachedMaxAttempts;
  HasReachedMaxAttemptsSuccess({required this.hasReachedMaxAttempts});
}

final class HasReachedMaxAttemptsFailure extends TestOverViewState {
  final String errMessage;
  HasReachedMaxAttemptsFailure({required this.errMessage});
}
