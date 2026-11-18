part of 'teacher_course_reviews_cubit.dart';

enum ReviewsLoadStatus { initial, loading, loaded, failure }

class TeacherCourseReviewsState {
  const TeacherCourseReviewsState({
    this.overviewStatus = ReviewsLoadStatus.initial,
    this.stats = const CourseRatingStatsEntity(),
    this.insights,
    this.listStatus = ReviewsLoadStatus.initial,
    this.query = CourseReviewsQuery.newest,
    this.reviews = const [],
    this.hasMore = false,
    this.loadingMore = false,
    this.pageFailed = false,
    this.errorMessage,
    this.lastSeenAt,
  });

  final ReviewsLoadStatus overviewStatus;
  final CourseRatingStatsEntity stats;
  final CourseReviewsInsights? insights;
  final ReviewsLoadStatus listStatus;
  final CourseReviewsQuery query;
  final List<CoursefeedbackItemEntity> reviews;
  final bool hasMore;
  final bool loadingMore;
  final bool pageFailed;
  final String? errorMessage;
  final DateTime? lastSeenAt;

  bool get statsReady => overviewStatus == ReviewsLoadStatus.loaded;

  bool get hasNoReviewsAtAll =>
      listStatus == ReviewsLoadStatus.loaded &&
      query.isNewest &&
      reviews.isEmpty;

  bool isNew(CoursefeedbackItemEntity review) {
    final lastSeen = lastSeenAt;
    return lastSeen != null && review.datePosted.isAfter(lastSeen);
  }

  TeacherCourseReviewsState copyWith({
    ReviewsLoadStatus? overviewStatus,
    CourseRatingStatsEntity? stats,
    CourseReviewsInsights? Function()? insights,
    ReviewsLoadStatus? listStatus,
    CourseReviewsQuery? query,
    List<CoursefeedbackItemEntity>? reviews,
    bool? hasMore,
    bool? loadingMore,
    bool? pageFailed,
    String? Function()? errorMessage,
    DateTime? Function()? lastSeenAt,
  }) {
    return TeacherCourseReviewsState(
      overviewStatus: overviewStatus ?? this.overviewStatus,
      stats: stats ?? this.stats,
      insights: insights == null ? this.insights : insights(),
      listStatus: listStatus ?? this.listStatus,
      query: query ?? this.query,
      reviews: reviews ?? this.reviews,
      hasMore: hasMore ?? this.hasMore,
      loadingMore: loadingMore ?? this.loadingMore,
      pageFailed: pageFailed ?? this.pageFailed,
      errorMessage: errorMessage == null ? this.errorMessage : errorMessage(),
      lastSeenAt: lastSeenAt == null ? this.lastSeenAt : lastSeenAt(),
    );
  }
}
