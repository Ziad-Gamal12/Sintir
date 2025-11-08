// ignore_for_file: file_names

part of 'CourseSubscribtionsCubit.dart';

@immutable
sealed class CourseSubscribtionsState {}

final class SubscribeToCoursesInitial extends CourseSubscribtionsState {}

final class PaymentSuccess extends CourseSubscribtionsState {
  final String token;
  PaymentSuccess({required this.token});
}

final class PaymentError extends CourseSubscribtionsState {
  final String message;
  PaymentError({required this.message});
}

final class PaymentLoading extends CourseSubscribtionsState {}

final class SubscibeingToCourseLoading extends CourseSubscribtionsState {}

final class SubscibeingToCourseSuccess extends CourseSubscribtionsState {}

final class SubscibeingToCourseFailure extends CourseSubscribtionsState {
  final String errMessge;

  SubscibeingToCourseFailure({required this.errMessge});
}

final class CheckIfSubscribedSuccess extends CourseSubscribtionsState {
  final bool isSubscribed;

  CheckIfSubscribedSuccess({required this.isSubscribed});
}

final class CheckIfSubscribedLoading extends CourseSubscribtionsState {}

final class CheckIfSubscribedFailure extends CourseSubscribtionsState {
  final String errMessage;

  CheckIfSubscribedFailure({required this.errMessage});
}

final class GetCourseSubscribersLoading extends CourseSubscribtionsState {}

final class GetCourseSubscribersSuccess extends CourseSubscribtionsState {
  final GetCourseSubscribersEntity response;
  GetCourseSubscribersSuccess({required this.response});
}

final class GetCourseSubscribersFailure extends CourseSubscribtionsState {
  final String errMessage;
  GetCourseSubscribersFailure({required this.errMessage});
}
//Paywith wallet

final class PayWithWalletLoading extends CourseSubscribtionsState {}

final class PayWithWalletSuccess extends CourseSubscribtionsState {
  final PayMobResponse response;
  PayWithWalletSuccess({required this.response});
}

final class PayWithWalletFailure extends CourseSubscribtionsState {
  final String errMessage;
  PayWithWalletFailure({required this.errMessage});
}
// search Subscribers

final class SearchSubscribersLoading extends CourseSubscribtionsState {
  final bool isPaginate;

  SearchSubscribersLoading({required this.isPaginate});
}

final class SearchSubscribersSuccess extends CourseSubscribtionsState {
  final GetCourseSubscribersEntity response;
  SearchSubscribersSuccess({required this.response});
}

final class SearchSubscribersFailure extends CourseSubscribtionsState {
  final String errMessage;
  SearchSubscribersFailure({required this.errMessage});
}
