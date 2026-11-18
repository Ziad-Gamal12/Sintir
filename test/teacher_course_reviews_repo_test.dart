import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Repos/TeacherCourseReviewsRepoImpl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';

class _FakeDocumentSnapshot extends Fake implements DocumentSnapshot<Object?> {}

typedef _Responder =
    FireStoreResponse Function(
      FireStoreRequirmentsEntity requirements,
      Map<String, dynamic>? query,
    );

class _FakeDatabase implements DataBaseService {
  _FakeDatabase(this.respond);

  final _Responder respond;
  final List<FireStoreRequirmentsEntity> requests = [];
  final List<Map<String, dynamic>?> queries = [];

  @override
  Future<FireStoreResponse> getData({
    required FireStoreRequirmentsEntity requirements,
    Map<String, dynamic>? query,
  }) async {
    requests.add(requirements);
    queries.add(query);
    return respond(requirements, query);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _StatsRepo implements CourseFeedBacksRepo {
  final List<String> requested = [];

  @override
  Future<Either<Failure, CourseRatingStatsEntity>> getCourseRatingStats({
    required String courseId,
  }) async {
    requested.add(courseId);
    return right(const CourseRatingStatsEntity(ratingsSum: 9, ratingsCount: 2));
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Map<String, dynamic> _review(String uid, {int? rating}) => {
  'uid': uid,
  'name': 'Student $uid',
  'userImage': '',
  'fedBack': '',
  'datePosted': Timestamp.fromDate(DateTime(2026, 11, 1)),
  if (rating != null) 'rating': rating,
};

Future<TeacherCourseReviewsRepoImpl> _repo(
  _FakeDatabase database, {
  _StatsRepo? stats,
  Map<String, Object> preferences = const {},
}) async {
  SharedPreferences.setMockInitialValues(preferences);
  return TeacherCourseReviewsRepoImpl(
    databaseservice: database,
    feedBacksRepo: stats ?? _StatsRepo(),
    preferences: await SharedPreferences.getInstance(),
  );
}

void main() {
  group('page queries', () {
    test('newest keeps the student page order', () {
      expect(TeacherCourseReviewsRepoImpl.pageQuery(
        CourseReviewsQuery.newest,
        null,
      ), {
        'orderBy': 'datePosted',
        'descending': true,
        'limit': TeacherCourseReviewsRepoImpl.pageSize,
        'startAfter': null,
      });
    });

    test('a star filters by rating and keeps newest first', () {
      final query = TeacherCourseReviewsRepoImpl.pageQuery(
        CourseReviewsQuery.stars(2),
        null,
      );
      expect(query['filters'], isA<List<Map<String, dynamic>>>());
      expect(query['filters'], [
        {'field': 'rating', 'operator': '==', 'value': 2},
      ]);
      expect(query['orderBy'], 'datePosted');
      expect(query['descending'], isTrue);
    });

    test('lowest rated sorts by rating, then newest', () {
      final query = TeacherCourseReviewsRepoImpl.pageQuery(
        CourseReviewsQuery.lowestRated,
        null,
      );
      expect(query.containsKey('filters'), isFalse);
      expect(query['orderBy'], isA<List<Map<String, dynamic>>>());
      expect(query['orderBy'], [
        {'field': 'rating', 'descending': false},
        {'field': 'datePosted', 'descending': true},
      ]);
    });

    test('recent reviews read from a date, newest first, capped', () {
      final since = DateTime(2026, 10, 18);
      final query = TeacherCourseReviewsRepoImpl.sinceQuery(since);
      expect(query['filters'], isA<List<Map<String, dynamic>>>());
      expect(query['filters'], [
        {
          'field': 'datePosted',
          'operator': '>=',
          'value': Timestamp.fromDate(since),
        },
      ]);
      expect(query['orderBy'], 'datePosted');
      expect(query['limit'], TeacherCourseReviewsRepoImpl.recentLimit);
      expect(query.containsKey('startAfter'), isFalse);
    });
  });

  group('reading', () {
    test('each filter keeps its own cursor', () async {
      final newestCursor = _FakeDocumentSnapshot();
      final starCursor = _FakeDocumentSnapshot();
      final database = _FakeDatabase((requirements, query) {
        final filtered = query!.containsKey('filters');
        return FireStoreResponse(
          listData: [_review(filtered ? 'five' : 'newest', rating: 5)],
          lastDocumentSnapshot: filtered ? starCursor : newestCursor,
          hasMore: true,
        );
      });
      final repo = await _repo(database);

      final first = await repo.getReviews(
        courseId: 'c1',
        query: CourseReviewsQuery.newest,
        isPaginate: false,
      );
      await repo.getReviews(
        courseId: 'c1',
        query: CourseReviewsQuery.stars(5),
        isPaginate: false,
      );
      await repo.getReviews(
        courseId: 'c1',
        query: CourseReviewsQuery.newest,
        isPaginate: true,
      );

      final page = first.getOrElse(() => fail('First page failed.'));
      expect(page.feedBacks.single.uid, 'newest');
      expect(page.hasMore, isTrue);
      expect(database.requests.first.docId, 'c1');
      expect(database.requests.first.subCollection, 'Feedbacks');
      expect(database.queries.last!['startAfter'], same(newestCursor));
    });

    test('a next page without a cursor does not read Firestore', () async {
      final database = _FakeDatabase(
        (requirements, query) => fail('Firestore must not be read.'),
      );
      final repo = await _repo(database);
      final result = await repo.getReviews(
        courseId: 'c1',
        query: CourseReviewsQuery.lowestRated,
        isPaginate: true,
      );
      final page = result.getOrElse(() => fail('Expected an empty page.'));
      expect(page.feedBacks, isEmpty);
      expect(page.hasMore, isFalse);
    });

    test('server errors become failures with their message', () async {
      final database = _FakeDatabase(
        (requirements, query) =>
            throw CustomException(message: 'index missing'),
      );
      final repo = await _repo(database);
      final result = await repo.getReviewsSince(
        courseId: 'c1',
        since: DateTime(2026, 10, 1),
      );
      expect(
        result.fold((failure) => failure.message, (_) => null),
        'index missing',
      );
    });

    test('rating stats come from the shared feedback repo', () async {
      final stats = _StatsRepo();
      final repo = await _repo(
        _FakeDatabase((requirements, query) => fail('Not expected.')),
        stats: stats,
      );
      final result = await repo.getRatingStats(courseId: 'c9');
      expect(stats.requested, ['c9']);
      expect(result.getOrElse(() => fail('Stats failed.')).ratingsCount, 2);
    });
  });

  group('last visit', () {
    test('is stored per course', () async {
      final repo = await _repo(
        _FakeDatabase((requirements, query) => fail('Not expected.')),
      );
      expect(repo.lastSeenAt('c1'), isNull);

      final seen = DateTime(2026, 11, 17, 9, 30);
      await repo.markSeen('c1', seen);

      expect(repo.lastSeenAt('c1'), seen);
      expect(repo.lastSeenAt('c2'), isNull);
    });
  });
}
