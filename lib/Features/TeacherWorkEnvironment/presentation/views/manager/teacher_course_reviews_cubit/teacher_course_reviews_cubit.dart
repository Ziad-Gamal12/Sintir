import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepo.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsInsights.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherCourseReviewsRepo.dart';

part 'teacher_course_reviews_state.dart';

class TeacherCourseReviewsCubit extends Cubit<TeacherCourseReviewsState> {
  TeacherCourseReviewsCubit({
    required this.repo,
    required this.courseId,
    this.moderation,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now,
       super(const TeacherCourseReviewsState());

  final TeacherCourseReviewsRepo repo;
  final String courseId;
  final ReviewModerationRepo? moderation;
  final DateTime Function() _clock;

  int _listGeneration = 0;
  int _overviewGeneration = 0;
  bool _started = false;
  bool _seenMarked = false;
  DateTime? _openedAt;

  Future<void> load() async {
    if (_started) return;
    _started = true;
    _openedAt = _clock();
    emit(state.copyWith(lastSeenAt: () => repo.lastSeenAt(courseId)));
    final overview = loadOverview();
    await _loadFirstPage(state.query);
    await overview;
  }

  Future<String?> refresh() async {
    final overview = loadOverview();
    final error = await _loadFirstPage(state.query, keepVisible: true);
    await overview;
    return error;
  }

  Future<void> selectQuery(CourseReviewsQuery query) async {
    if (query == state.query && state.listStatus != ReviewsLoadStatus.failure) {
      return;
    }
    await _loadFirstPage(query);
  }

  Future<void> toggleStar(int star) => selectQuery(
    state.query.star == star
        ? CourseReviewsQuery.newest
        : CourseReviewsQuery.stars(star),
  );

  Future<void> retryList() => _loadFirstPage(state.query);

  Future<void> loadOverview() async {
    final generation = ++_overviewGeneration;
    if (!state.statsReady) {
      emit(state.copyWith(overviewStatus: ReviewsLoadStatus.loading));
    }
    final now = _clock();
    final lastSeen = state.lastSeenAt;
    final statsRequest = repo.getRatingStats(courseId: courseId);
    final recentRequest = repo.getReviewsSince(
      courseId: courseId,
      since: CourseReviewsInsights.fetchSince(now: now, lastSeen: lastSeen),
    );
    final statsResult = await statsRequest;
    final recentResult = await recentRequest;
    if (isClosed || generation != _overviewGeneration) return;

    statsResult.fold(
      (_) {
        if (!state.statsReady) {
          emit(state.copyWith(overviewStatus: ReviewsLoadStatus.failure));
        }
      },
      (stats) {
        final insights = recentResult.fold<CourseReviewsInsights?>(
          (_) => state.insights,
          (recent) => CourseReviewsInsights.compute(
            reviews: recent.feedBacks,
            isComplete: !recent.hasMore,
            overallAverage: stats.average,
            now: now,
            lastSeen: lastSeen,
          ),
        );
        emit(
          state.copyWith(
            overviewStatus: ReviewsLoadStatus.loaded,
            stats: stats,
            insights: () => insights,
          ),
        );
      },
    );
  }

  Future<void> loadMore() async {
    final current = state;
    if (current.listStatus != ReviewsLoadStatus.loaded ||
        !current.hasMore ||
        current.loadingMore ||
        current.pageFailed) {
      return;
    }
    final generation = _listGeneration;
    emit(current.copyWith(loadingMore: true));
    final result = await repo.getReviews(
      courseId: courseId,
      query: current.query,
      isPaginate: true,
    );
    if (isClosed || generation != _listGeneration) return;

    result.fold(
      (failure) => emit(
        state.copyWith(
          loadingMore: false,
          pageFailed: true,
          errorMessage: () => failure.message,
        ),
      ),
      (page) => emit(
        state.copyWith(
          loadingMore: false,
          reviews: _merge(state.reviews, page.feedBacks),
          hasMore: page.hasMore,
        ),
      ),
    );
  }

  Future<void> retryPage() async {
    if (!state.pageFailed) return;
    emit(state.copyWith(pageFailed: false));
    await loadMore();
  }

  Future<String?> _loadFirstPage(
    CourseReviewsQuery query, {
    bool keepVisible = false,
  }) async {
    final generation = ++_listGeneration;
    final keep = keepVisible && state.listStatus == ReviewsLoadStatus.loaded;
    emit(
      keep
          ? state.copyWith(loadingMore: false, pageFailed: false)
          : state.copyWith(
              query: query,
              listStatus: ReviewsLoadStatus.loading,
              reviews: const [],
              hasMore: false,
              loadingMore: false,
              pageFailed: false,
              errorMessage: () => null,
            ),
    );
    final result = await repo.getReviews(
      courseId: courseId,
      query: query,
      isPaginate: false,
    );
    if (isClosed || generation != _listGeneration) return null;

    return result.fold<String?>(
      (failure) {
        if (!keep) {
          emit(
            state.copyWith(
              listStatus: ReviewsLoadStatus.failure,
              errorMessage: () => failure.message,
            ),
          );
        }
        return failure.message;
      },
      (page) {
        emit(
          state.copyWith(
            query: query,
            listStatus: ReviewsLoadStatus.loaded,
            reviews: List.unmodifiable(page.feedBacks),
            hasMore: page.hasMore,
            errorMessage: () => null,
          ),
        );
        _markSeenOnce();
        return null;
      },
    );
  }

  Future<String?> saveReply(
    CoursefeedbackItemEntity review,
    String text,
  ) async {
    final repo = moderation;
    if (repo == null) return LocaleKeys.errorOccurredMessage;
    final result = await repo.saveReply(
      courseId: courseId,
      review: review,
      text: text,
    );
    return result.fold((failure) => failure.message, (reply) {
      _replaceReview(review.uid, (current) => current.copyWith(teacherReply: reply));
      return null;
    });
  }

  Future<String?> deleteReply(CoursefeedbackItemEntity review) async {
    final repo = moderation;
    if (repo == null) return LocaleKeys.errorOccurredMessage;
    final result = await repo.deleteReply(
      courseId: courseId,
      reviewUid: review.uid,
    );
    return result.fold((failure) => failure.message, (_) {
      _replaceReview(review.uid, (current) => current.copyWith(clearReply: true));
      return null;
    });
  }

  Future<String?> reportReview(
    CoursefeedbackItemEntity review,
    ReviewReportReason reason,
    String details,
  ) async {
    final repo = moderation;
    if (repo == null) return LocaleKeys.errorOccurredMessage;
    final result = await repo.reportReview(
      courseId: courseId,
      reviewUid: review.uid,
      reason: reason,
      details: details,
    );
    return result.fold((failure) => failure.message, (_) => null);
  }

  void _replaceReview(
    String uid,
    CoursefeedbackItemEntity Function(CoursefeedbackItemEntity current) update,
  ) {
    if (isClosed) return;
    emit(
      state.copyWith(
        reviews: List.unmodifiable([
          for (final review in state.reviews)
            review.uid == uid ? update(review) : review,
        ]),
      ),
    );
  }

  void _markSeenOnce() {
    final openedAt = _openedAt;
    if (_seenMarked || openedAt == null) return;
    _seenMarked = true;
    unawaited(repo.markSeen(courseId, openedAt));
  }

  static List<CoursefeedbackItemEntity> _merge(
    List<CoursefeedbackItemEntity> current,
    List<CoursefeedbackItemEntity> next,
  ) {
    final uids = {for (final review in current) review.uid};
    final merged = List.of(current);
    for (final review in next) {
      if (uids.add(review.uid)) merged.add(review);
    }
    return List.unmodifiable(merged);
  }
}
