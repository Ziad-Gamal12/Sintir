part of 'my_course_rating_cubit.dart';

enum CourseRatingLoadStatus { initial, loading, loaded, failure }

enum CourseRatingAction {
  idle,
  saving,
  saved,
  saveFailed,
  deleting,
  deleted,
  deleteFailed,
}

@immutable
class MyCourseRatingState {
  const MyCourseRatingState({
    this.loadStatus = CourseRatingLoadStatus.initial,
    this.action = CourseRatingAction.idle,
    this.stats = const CourseRatingStatsEntity(),
    this.myFeedback,
    this.errorMessage,
    this.hasLoadedOnce = false,
  });

  final CourseRatingLoadStatus loadStatus;
  final CourseRatingAction action;

  final CourseRatingStatsEntity stats;

  final CoursefeedbackItemEntity? myFeedback;
  final String? errorMessage;

  final bool hasLoadedOnce;

  bool get isBusy =>
      action == CourseRatingAction.saving ||
      action == CourseRatingAction.deleting;

  bool get hasMyRating => myFeedback?.rating != null;

  static const Object _unchanged = Object();

  MyCourseRatingState copyWith({
    CourseRatingLoadStatus? loadStatus,
    CourseRatingAction? action,
    CourseRatingStatsEntity? stats,
    Object? myFeedback = _unchanged,
    Object? errorMessage = _unchanged,
    bool? hasLoadedOnce,
  }) {
    return MyCourseRatingState(
      loadStatus: loadStatus ?? this.loadStatus,
      action: action ?? this.action,
      stats: stats ?? this.stats,
      myFeedback: identical(myFeedback, _unchanged)
          ? this.myFeedback
          : myFeedback as CoursefeedbackItemEntity?,
      errorMessage: identical(errorMessage, _unchanged)
          ? this.errorMessage
          : errorMessage as String?,
      hasLoadedOnce: hasLoadedOnce ?? this.hasLoadedOnce,
    );
  }
}
