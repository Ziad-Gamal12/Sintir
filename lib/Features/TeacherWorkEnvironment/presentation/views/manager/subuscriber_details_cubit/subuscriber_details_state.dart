part of 'subuscriber_details_cubit.dart';

@immutable
sealed class SubscriberDetailsState {}

final class SubuscriberDetailsInitial extends SubscriberDetailsState {}

final class GetSubscriberResultsLoading extends SubscriberDetailsState {}

final class GetSubscriberResultsFailure extends SubscriberDetailsState {
  GetSubscriberResultsFailure({required this.errmessage});
  final String errmessage;
}

final class GetSubscriberResultsSuccess extends SubscriberDetailsState {
  GetSubscriberResultsSuccess({required this.results, required this.summary});
  final List<TestResultEntity> results;
  final SubscriberPerformanceSummary summary;
}

final class GetSubscriberHighestScoreLoading extends SubscriberDetailsState {}

final class GetSubscriberHighestScoreFailure extends SubscriberDetailsState {
  GetSubscriberHighestScoreFailure({required this.errmessage});
  final String errmessage;
}

final class GetSubscriberHighestScoreSuccess extends SubscriberDetailsState {
  GetSubscriberHighestScoreSuccess({required this.result});
  final TestResultEntity result;
}

final class GetSubscriberLowestScoreLoading extends SubscriberDetailsState {}

final class GetSubscriberLowestScoreFailure extends SubscriberDetailsState {
  GetSubscriberLowestScoreFailure({required this.errmessage});
  final String errmessage;
}

final class GetSubscriberLowestScoreSuccess extends SubscriberDetailsState {
  GetSubscriberLowestScoreSuccess({required this.result});
  final TestResultEntity result;
}

final class GetSubscibersEnrolledCoursesForTeacherLoading
    extends SubscriberDetailsState {}

final class GetSubscibersEnrolledCoursesForTeacherFailure
    extends SubscriberDetailsState {
  GetSubscibersEnrolledCoursesForTeacherFailure({required this.errmessage});
  final String errmessage;
}

final class GetSubscibersEnrolledCoursesForTeacherSuccess
    extends SubscriberDetailsState {
  GetSubscibersEnrolledCoursesForTeacherSuccess({required this.courses});
  final List<CourseEntity> courses;
}

final class SubscriberAvrageCalculationSuccess extends SubscriberDetailsState {
  SubscriberAvrageCalculationSuccess({required this.avrage});
  final double avrage;
}
