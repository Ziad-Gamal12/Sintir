part of 'course_feed_backs_cubit.dart';

@immutable
sealed class CourseFeedBacksState {}

final class CourseFeedBacksInitial extends CourseFeedBacksState {}

final class CourseFeedBacksGetFeedBackLoading extends CourseFeedBacksState {
  CourseFeedBacksGetFeedBackLoading({this.isPaginate = false});

  /// True while loading a next page (the loaded reviews stay visible).
  final bool isPaginate;
}

final class CourseFeedBacksGetFeedBackSuccess extends CourseFeedBacksState {
  final GetCourseFeedBacksResponseEntity response;
  CourseFeedBacksGetFeedBackSuccess({required this.response});
}

final class CourseFeedBacksGetFeedBackFailure extends CourseFeedBacksState {
  final String errMessage;
  final bool isPaginate;
  CourseFeedBacksGetFeedBackFailure({
    required this.errMessage,
    this.isPaginate = false,
  });
}
