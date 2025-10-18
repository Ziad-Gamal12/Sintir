part of 'test_consequences_cubit.dart';

@immutable
sealed class TestConsequencesState {}

final class TestConsequencesInitial extends TestConsequencesState {}

final class TestConsequencesGetHighestScorLoading
    extends TestConsequencesState {}

final class TestConsequencesGetHighestScorSuccess
    extends TestConsequencesState {
  final TestResultEntity testResultEntity;

  TestConsequencesGetHighestScorSuccess({required this.testResultEntity});
}

final class TestConsequencesGetHighestScorFailure
    extends TestConsequencesState {
  final String errMessage;

  TestConsequencesGetHighestScorFailure({required this.errMessage});
}

final class TestConsequencesGetLowestScorLoading
    extends TestConsequencesState {}

final class TestConsequencesGetLowestScorSuccess extends TestConsequencesState {
  final TestResultEntity testResultEntity;

  TestConsequencesGetLowestScorSuccess({required this.testResultEntity});
}

final class TestConsequencesGetLowestScorFailure extends TestConsequencesState {
  final String errMessage;

  TestConsequencesGetLowestScorFailure({required this.errMessage});
}

final class TestConsequencesGetAttendedCountLoading
    extends TestConsequencesState {}

final class TestConsequencesGetAttendedCountSuccess
    extends TestConsequencesState {
  final int count;

  TestConsequencesGetAttendedCountSuccess({required this.count});
}

final class TestConsequencesGetAttendedCountFailure
    extends TestConsequencesState {
  final String errMessage;

  TestConsequencesGetAttendedCountFailure({required this.errMessage});
}

final class TestConsequencesGetFailedCountLoading
    extends TestConsequencesState {}

final class TestConsequencesGetFailedCountSuccess
    extends TestConsequencesState {
  final int count;

  TestConsequencesGetFailedCountSuccess({required this.count});
}

final class TestConsequencesGetFailedCountFailure
    extends TestConsequencesState {
  final String errMessage;

  TestConsequencesGetFailedCountFailure({required this.errMessage});
}

final class TestConsequencesGetSuccessedCountLoading
    extends TestConsequencesState {}

final class TestConsequencesGetSuccessedCountSuccess
    extends TestConsequencesState {
  final int count;

  TestConsequencesGetSuccessedCountSuccess({required this.count});
}

final class TestConsequencesGetSuccessedCountFailure
    extends TestConsequencesState {
  final String errMessage;

  TestConsequencesGetSuccessedCountFailure({required this.errMessage});
}

final class TestConsequencesGetTotalStudentsCountLoading
    extends TestConsequencesState {}

final class TestConsequencesGetTotalStudentsCountSuccess
    extends TestConsequencesState {
  final int count;

  TestConsequencesGetTotalStudentsCountSuccess({required this.count});
}

final class TestConsequencesGetTotalStudentsCountFailure
    extends TestConsequencesState {
  final String errMessage;

  TestConsequencesGetTotalStudentsCountFailure({required this.errMessage});
}
