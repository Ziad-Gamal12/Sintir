import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsInsights.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherCourseReviewsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_course_reviews_cubit/teacher_course_reviews_cubit.dart';

typedef _PageResult = Either<Failure, GetCourseFeedBacksResponseEntity>;

final _now = DateTime(2026, 11, 17, 12);

class _GatedRepo implements TeacherCourseReviewsRepo {
  final List<CourseReviewsQuery> queries = [];
  final List<bool> paginates = [];
  final List<Completer<_PageResult>> pages = [];
  Either<Failure, CourseRatingStatsEntity> stats = right(
    const CourseRatingStatsEntity(
      ratingsSum: 16,
      ratingsCount: 4,
      distribution: {5: 1, 4: 2, 3: 1},
    ),
  );
  _PageResult recent = right(_page(const []));
  DateTime? since;
  DateTime? storedSeen;
  final List<DateTime> marked = [];

  @override
  Future<_PageResult> getReviews({
    required String courseId,
    required CourseReviewsQuery query,
    required bool isPaginate,
  }) {
    queries.add(query);
    paginates.add(isPaginate);
    final page = Completer<_PageResult>();
    pages.add(page);
    return page.future;
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity>> getRatingStats({
    required String courseId,
  }) async => stats;

  @override
  Future<_PageResult> getReviewsSince({
    required String courseId,
    required DateTime since,
  }) async {
    this.since = since;
    return recent;
  }

  @override
  DateTime? lastSeenAt(String courseId) => storedSeen;

  @override
  Future<void> markSeen(String courseId, DateTime at) async => marked.add(at);
}

GetCourseFeedBacksResponseEntity _page(
  List<CoursefeedbackItemEntity> reviews, {
  bool hasMore = false,
}) => GetCourseFeedBacksResponseEntity(
  feedBacks: reviews,
  hasMore: hasMore,
  isPaginate: false,
);

CoursefeedbackItemEntity _review(
  String uid, {
  int rating = 4,
  int daysAgo = 1,
}) {
  return CoursefeedbackItemEntity(
    userImage: '',
    name: 'Student $uid',
    uid: uid,
    fedBack: '',
    datePosted: _now.subtract(Duration(days: daysAgo)),
    rating: rating,
  );
}

TeacherCourseReviewsCubit _cubit(_GatedRepo repo) =>
    TeacherCourseReviewsCubit(repo: repo, courseId: 'c1', clock: () => _now);

List<String> _uids(TeacherCourseReviewsCubit cubit) =>
    cubit.state.reviews.map((review) => review.uid).toList();

Future<TeacherCourseReviewsCubit> _loaded(
  _GatedRepo repo,
  List<CoursefeedbackItemEntity> reviews, {
  bool hasMore = false,
}) async {
  final cubit = _cubit(repo);
  final loading = cubit.load();
  await pumpEventQueue();
  repo.pages.last.complete(right(_page(reviews, hasMore: hasMore)));
  await loading;
  return cubit;
}

void main() {
  test('load reads the last visit, then marks this visit once', () async {
    final repo = _GatedRepo()
      ..storedSeen = _now.subtract(const Duration(days: 3))
      ..recent = right(
        _page([
          _review('a', rating: 5),
          _review('b', rating: 5, daysAgo: 2),
          _review('c', rating: 5, daysAgo: 5),
        ]),
      );
    final cubit = _cubit(repo);
    final loading = cubit.load();
    await pumpEventQueue();

    expect(cubit.state.lastSeenAt, repo.storedSeen);
    expect(cubit.state.listStatus, ReviewsLoadStatus.loading);
    expect(repo.queries, [CourseReviewsQuery.newest]);
    expect(repo.paginates, [false]);
    expect(repo.marked, isEmpty);

    final fresh = _review('fresh');
    final old = _review('old', daysAgo: 10);
    repo.pages.single.complete(right(_page([fresh, old])));
    await loading;

    expect(_uids(cubit), ['fresh', 'old']);
    expect(cubit.state.isNew(fresh), isTrue);
    expect(cubit.state.isNew(old), isFalse);
    expect(repo.marked, [_now]);
    expect(repo.since, _now.subtract(const Duration(days: 30)));
    expect(cubit.state.overviewStatus, ReviewsLoadStatus.loaded);
    expect(cubit.state.stats.ratingsCount, 4);
    expect(cubit.state.insights?.trend, CourseReviewsTrend.up);
    expect(cubit.state.insights?.newCount, 2);

    await cubit.load();
    expect(repo.queries, hasLength(1));
    await cubit.close();
  });

  test('a slow answer for an old filter never replaces the new one', () async {
    final repo = _GatedRepo();
    final cubit = _cubit(repo);
    final loading = cubit.load();
    await pumpEventQueue();
    final filtering = cubit.selectQuery(CourseReviewsQuery.stars(1));
    await pumpEventQueue();
    expect(repo.queries, [
      CourseReviewsQuery.newest,
      CourseReviewsQuery.stars(1),
    ]);

    repo.pages[1].complete(right(_page([_review('low', rating: 1)])));
    await filtering;
    repo.pages[0].complete(right(_page([_review('newest')])));
    await loading;

    expect(cubit.state.query, CourseReviewsQuery.stars(1));
    expect(_uids(cubit), ['low']);
    await cubit.close();
  });

  test('tapping the selected star again goes back to newest', () async {
    final repo = _GatedRepo();
    final cubit = await _loaded(repo, [_review('a')]);

    final first = cubit.toggleStar(5);
    await pumpEventQueue();
    expect(cubit.state.query, CourseReviewsQuery.stars(5));
    repo.pages.last.complete(right(_page([_review('five', rating: 5)])));
    await first;

    final second = cubit.toggleStar(5);
    await pumpEventQueue();
    repo.pages.last.complete(right(_page([_review('a')])));
    await second;

    expect(repo.queries, [
      CourseReviewsQuery.newest,
      CourseReviewsQuery.stars(5),
      CourseReviewsQuery.newest,
    ]);
    expect(cubit.state.query, CourseReviewsQuery.newest);

    await cubit.selectQuery(CourseReviewsQuery.newest);
    expect(repo.queries, hasLength(3));
    await cubit.close();
  });

  test('load more skips duplicates and retries a failed page', () async {
    final repo = _GatedRepo();
    final cubit = await _loaded(repo, [
      _review('a'),
      _review('b'),
    ], hasMore: true);

    final failing = cubit.loadMore();
    await pumpEventQueue();
    expect(cubit.state.loadingMore, isTrue);
    expect(repo.paginates.last, isTrue);
    repo.pages.last.complete(left(ServerFailure(message: 'offline')));
    await failing;

    expect(cubit.state.pageFailed, isTrue);
    expect(cubit.state.loadingMore, isFalse);
    expect(_uids(cubit), ['a', 'b']);

    await cubit.loadMore();
    expect(repo.pages, hasLength(2));

    final retry = cubit.retryPage();
    await pumpEventQueue();
    expect(repo.pages, hasLength(3));
    repo.pages.last.complete(right(_page([_review('b'), _review('c')])));
    await retry;

    expect(_uids(cubit), ['a', 'b', 'c']);
    expect(cubit.state.hasMore, isFalse);
    expect(cubit.state.pageFailed, isFalse);
    await cubit.close();
  });

  test('a failed refresh keeps the list and returns the message', () async {
    final repo = _GatedRepo();
    final cubit = await _loaded(repo, [_review('a')]);

    final refreshing = cubit.refresh();
    await pumpEventQueue();
    expect(cubit.state.listStatus, ReviewsLoadStatus.loaded);
    repo.pages.last.complete(left(ServerFailure(message: 'offline')));

    expect(await refreshing, 'offline');
    expect(cubit.state.listStatus, ReviewsLoadStatus.loaded);
    expect(_uids(cubit), ['a']);
    await cubit.close();
  });

  test('the visit is marked only after the first page succeeds', () async {
    final repo = _GatedRepo();
    final cubit = _cubit(repo);
    final loading = cubit.load();
    await pumpEventQueue();
    repo.pages.last.complete(left(ServerFailure(message: 'offline')));
    await loading;

    expect(cubit.state.listStatus, ReviewsLoadStatus.failure);
    expect(cubit.state.errorMessage, 'offline');
    expect(repo.marked, isEmpty);

    final retry = cubit.retryList();
    await pumpEventQueue();
    repo.pages.last.complete(right(_page([_review('a')])));
    await retry;

    expect(cubit.state.listStatus, ReviewsLoadStatus.loaded);
    expect(repo.marked, [_now]);
    await cubit.close();
  });

  test('stats fail once, then a failed refresh keeps them', () async {
    final repo = _GatedRepo()
      ..stats = left(ServerFailure(message: 'offline'));
    final cubit = await _loaded(repo, [_review('a')]);
    expect(cubit.state.overviewStatus, ReviewsLoadStatus.failure);

    repo.stats = right(
      const CourseRatingStatsEntity(ratingsSum: 9, ratingsCount: 2),
    );
    await cubit.loadOverview();
    expect(cubit.state.overviewStatus, ReviewsLoadStatus.loaded);

    repo.stats = left(ServerFailure(message: 'offline'));
    await cubit.loadOverview();
    expect(cubit.state.overviewStatus, ReviewsLoadStatus.loaded);
    expect(cubit.state.stats.ratingsCount, 2);
    await cubit.close();
  });

  test('no reviews counts as empty only for newest', () async {
    final repo = _GatedRepo();
    final cubit = await _loaded(repo, const []);
    expect(cubit.state.hasNoReviewsAtAll, isTrue);

    final filtering = cubit.selectQuery(CourseReviewsQuery.lowestRated);
    await pumpEventQueue();
    repo.pages.last.complete(right(_page(const [])));
    await filtering;
    expect(cubit.state.hasNoReviewsAtAll, isFalse);
    await cubit.close();
  });
}
