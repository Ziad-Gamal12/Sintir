part of 'subuscriber_details_cubit.dart';

@immutable
sealed class SubscriberDetailsState {}

final class SubuscriberDetailsInitial extends SubscriberDetailsState {}

// getSubscriberResults
final class GetSubscriberResultsLoading extends SubscriberDetailsState {}

final class GetSubscriberResultsFailure extends SubscriberDetailsState {
  final String errmessage;
  GetSubscriberResultsFailure({required this.errmessage});
}

final class GetSubscriberResultsSuccess extends SubscriberDetailsState {
  final List<TestResultEntity> results;
  GetSubscriberResultsSuccess({required this.results});
}

//getSubscriberHighestScore
final class GetSubscriberHighestScoreLoading extends SubscriberDetailsState {}

final class GetSubscriberHighestScoreFailure extends SubscriberDetailsState {
  final String errmessage;
  GetSubscriberHighestScoreFailure({required this.errmessage});
}

final class GetSubscriberHighestScoreSuccess extends SubscriberDetailsState {
  final TestResultEntity result;
  GetSubscriberHighestScoreSuccess({required this.result});
}

//getSubscriberLowestScore
final class GetSubscriberLowestScoreLoading extends SubscriberDetailsState {}

final class GetSubscriberLowestScoreFailure extends SubscriberDetailsState {
  final String errmessage;
  GetSubscriberLowestScoreFailure({required this.errmessage});
}

final class GetSubscriberLowestScoreSuccess extends SubscriberDetailsState {
  final TestResultEntity result;
  GetSubscriberLowestScoreSuccess({required this.result});
}

//getSubscibersEnrolledCoursesForTeacher
final class GetSubscibersEnrolledCoursesForTeacherLoading
    extends SubscriberDetailsState {}

final class GetSubscibersEnrolledCoursesForTeacherFailure
    extends SubscriberDetailsState {
  final String errmessage;
  GetSubscibersEnrolledCoursesForTeacherFailure({required this.errmessage});
}

final class GetSubscibersEnrolledCoursesForTeacherSuccess
    extends SubscriberDetailsState {
  final List<CourseEntity> courses;
  GetSubscibersEnrolledCoursesForTeacherSuccess({required this.courses});
}

final class SubscriberAvrageCalculationSuccess extends SubscriberDetailsState {
  final double avrage;
  SubscriberAvrageCalculationSuccess({required this.avrage});
}
