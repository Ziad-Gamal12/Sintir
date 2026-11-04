part of 'course_checkout_cubit.dart';

sealed class CourseCheckoutState {}

class CourseCheckoutInitial extends CourseCheckoutState {}

class CourseCheckoutLoading extends CourseCheckoutState {}

class CourseCheckoutQuoteReady extends CourseCheckoutState {
  CourseCheckoutQuoteReady(this.quote);
  final CourseCheckoutQuote quote;
}

class CourseCheckoutCreated extends CourseCheckoutState {
  CourseCheckoutCreated(this.attempt);
  final CoursePaymentAttempt attempt;
}

class CourseCheckoutStatus extends CourseCheckoutState {
  CourseCheckoutStatus(this.result);
  final CoursePaymentStatusResult result;
  String get status => result.status;
}

class CourseCheckoutFailure extends CourseCheckoutState {
  CourseCheckoutFailure(this.message);
  final String message;
}

class CourseCheckoutRecoveryRequired extends CourseCheckoutState {
  CourseCheckoutRecoveryRequired(this.message);
  final String message;
}

class CourseCheckoutReviewRequired extends CourseCheckoutState {
  CourseCheckoutReviewRequired(this.message);
  final String message;
}
