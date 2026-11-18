import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepoImpli.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/course_feedback_error_messages.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/locale_keys.dart';

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

CourseFeedBacksRepoImpli _repo({
  _FakeDatabase? database,
  EdgeFunctionInvoker? invoker,
}) {
  return CourseFeedBacksRepoImpli(
    databaseservice:
        database ??
        _FakeDatabase(
          (requirements, query) => fail('Firestore must not be read.'),
        ),
    edgeFunctions: EdgeFunctionsService(
      tokenProvider: () async => 'firebase-id-token',
      invoker:
          invoker ??
          (name, body, token) async =>
              fail('No Edge Function call was expected.'),
    ),
  );
}

Map<String, dynamic> _review(String uid, {int? rating, String text = ''}) => {
  'uid': uid,
  'name': 'Student $uid',
  'userImage': '',
  'fedBack': text,
  'datePosted': Timestamp.fromDate(DateTime(2026, 11, 1)),
  if (rating != null) 'rating': rating,
};

Map<String, dynamic> _savedResponse() => {
  'ok': true,
  'created': true,
  'feedback': {
    'uid': 's1',
    'name': 'Ziad Gamal',
    'userImage': '',
    'fedBack': 'great',
    'rating': 4,
    'datePosted': '2026-11-17T10:00:00.000Z',
    'updatedAt': '2026-11-17T10:00:00.000Z',
  },
  'stats': {
    'ratingsSum': 4,
    'ratingsCount': 1,
    'averageRating': 4,
    'ratingDistribution': {'1': 0, '2': 0, '3': 0, '4': 1, '5': 0},
    'feedBacksCount': 1,
  },
};

void main() {
  group('reading', () {
    test('pages are newest first with one cursor per course', () async {
      final cursorA = _FakeDocumentSnapshot();
      final cursorB = _FakeDocumentSnapshot();
      final database = _FakeDatabase((requirements, query) {
        final courseId = requirements.docId!;
        return FireStoreResponse(
          listData: [
            _review('$courseId-1', rating: 5),
            {'broken': true},
          ],
          lastDocumentSnapshot: courseId == 'A' ? cursorA : cursorB,
          hasMore: true,
        );
      });
      final repo = _repo(database: database);

      final firstA = await repo.getCourseFedBacks(
        courseId: 'A',
        isPaginate: false,
      );
      await repo.getCourseFedBacks(courseId: 'B', isPaginate: false);
      await repo.getCourseFedBacks(courseId: 'A', isPaginate: true);

      final page = firstA.getOrElse(() => fail('Page A failed.'));
      expect(page.feedBacks.map((review) => review.uid).toList(), ['A-1']);
      expect(page.hasMore, isTrue);
      expect(database.requests.first.collection, 'Courses');
      expect(database.requests.first.subCollection, 'Feedbacks');
      expect(database.queries.first, {
        'orderBy': 'datePosted',
        'descending': true,
        'limit': 10,
        'startAfter': null,
      });
      // Course B's first page must not move course A's cursor.
      expect(database.queries.last!['startAfter'], same(cursorA));
    });

    test('paginating before any page returns an empty last page', () async {
      final database = _FakeDatabase(
        (requirements, query) => fail('Firestore must not be read.'),
      );
      final result = await _repo(
        database: database,
      ).getCourseFedBacks(courseId: 'A', isPaginate: true);
      final page = result.getOrElse(() => fail('Failed.'));
      expect(page.feedBacks, isEmpty);
      expect(page.hasMore, isFalse);
      expect(database.requests, isEmpty);
    });

    test('a failed refresh keeps paging where it was', () async {
      final cursor = _FakeDocumentSnapshot();
      var call = 0;
      final database = _FakeDatabase((requirements, query) {
        call++;
        if (call == 2) throw CustomException(message: 'offline');
        return FireStoreResponse(
          listData: [_review('s$call', rating: 5)],
          lastDocumentSnapshot: cursor,
          hasMore: true,
        );
      });
      final repo = _repo(database: database);

      await repo.getCourseFedBacks(courseId: 'A', isPaginate: false);
      final refresh = await repo.getCourseFedBacks(
        courseId: 'A',
        isPaginate: false,
      );
      expect(refresh.isLeft(), isTrue);
      await repo.getCourseFedBacks(courseId: 'A', isPaginate: true);

      // The refresh asked for the top; the next page still follows page one.
      expect(database.queries[1]!['startAfter'], isNull);
      expect(database.queries[2]!['startAfter'], same(cursor));
    });

    test('a successful refresh moves the cursor; an empty one clears it', () async {
      final first = _FakeDocumentSnapshot();
      final refreshed = _FakeDocumentSnapshot();
      var call = 0;
      final database = _FakeDatabase((requirements, query) {
        call++;
        return switch (call) {
          1 => FireStoreResponse(
            listData: [_review('s1', rating: 5)],
            lastDocumentSnapshot: first,
            hasMore: true,
          ),
          2 => FireStoreResponse(
            listData: [_review('s2', rating: 4)],
            lastDocumentSnapshot: refreshed,
            hasMore: true,
          ),
          _ => FireStoreResponse(listData: const [], hasMore: false),
        };
      });
      final repo = _repo(database: database);

      await repo.getCourseFedBacks(courseId: 'A', isPaginate: false);
      await repo.getCourseFedBacks(courseId: 'A', isPaginate: false);
      await repo.getCourseFedBacks(courseId: 'A', isPaginate: true);
      expect(database.queries[2]!['startAfter'], same(refreshed));

      // A refresh that finds no reviews leaves nothing to page through.
      await repo.getCourseFedBacks(courseId: 'A', isPaginate: false);
      final page = (await repo.getCourseFedBacks(
        courseId: 'A',
        isPaginate: true,
      )).getOrElse(() => fail('Failed.'));
      expect(page.feedBacks, isEmpty);
      expect(page.hasMore, isFalse);
      expect(database.requests, hasLength(4));
    });

    test('Firestore errors become failures with their message', () async {
      final database = _FakeDatabase(
        (requirements, query) => throw CustomException(message: 'offline'),
      );
      final result = await _repo(
        database: database,
      ).getCourseFedBacks(courseId: 'A', isPaginate: false);
      expect(result.fold((failure) => failure.message, (_) => 'ok'), 'offline');
    });

    test('the summary is read live from the course document', () async {
      final database = _FakeDatabase((requirements, query) {
        expect(requirements.collection, 'Courses');
        expect(requirements.docId, 'A');
        expect(requirements.subCollection, isNull);
        return FireStoreResponse(
          docData: {
            'ratingsSum': 9,
            'ratingsCount': 2,
            'ratingDistribution': {'4': 1, '5': 1},
          },
        );
      });
      final result = await _repo(
        database: database,
      ).getCourseRatingStats(courseId: 'A');
      expect(result.getOrElse(() => fail('Failed.')).average, 4.5);
    });

    test('my review: missing is null, an old one without stars is read', () async {
      final missing = _FakeDatabase(
        (requirements, query) => FireStoreResponse(docData: null),
      );
      final none = await _repo(
        database: missing,
      ).getMyCourseFeedback(courseId: 'A', uid: 's1');
      expect(none.getOrElse(() => fail('Failed.')), isNull);

      final legacy = _FakeDatabase((requirements, query) {
        expect(requirements.subDocId, 's1');
        return FireStoreResponse(docData: _review('s1', text: 'old review'));
      });
      final mine = (await _repo(
        database: legacy,
      ).getMyCourseFeedback(courseId: 'A', uid: 's1')).getOrElse(
        () => fail('Failed.'),
      );
      expect(mine!.rating, isNull);
      expect(mine.fedBack, 'old review');
    });
  });

  group('writing', () {
    test('saving sends trimmed text and the teacher hint', () async {
      String? sentName;
      Map<String, dynamic>? sentBody;
      final repo = _repo(
        invoker: (name, body, token) async {
          sentName = name;
          sentBody = body;
          return EdgeFunctionResponse(status: 200, data: _savedResponse());
        },
      );

      final result = await repo.saveMyCourseFeedback(
        courseId: 'A',
        rating: 4,
        text: '  great  ',
        teacherId: 't1',
      );

      final saved = result.getOrElse(() => fail('Failed.'));
      expect(sentName, 'upsert-course-feedback');
      expect(sentBody, {
        'courseId': 'A',
        'rating': 4,
        'text': 'great',
        'teacherId': 't1',
      });
      expect(saved.created, isTrue);
      expect(saved.feedback.rating, 4);
      expect(saved.stats.average, 4);
      expect(saved.stats.countFor(4), 1);
    });

    test('an empty teacher hint is not sent', () async {
      Map<String, dynamic>? sentBody;
      final repo = _repo(
        invoker: (name, body, token) async {
          sentBody = body;
          return EdgeFunctionResponse(status: 200, data: _savedResponse());
        },
      );
      await repo.saveMyCourseFeedback(
        courseId: 'A',
        rating: 4,
        text: '',
        teacherId: '',
      );
      expect(sentBody!.containsKey('teacherId'), isFalse);
    });

    test('invalid input never reaches the server', () async {
      final repo = _repo();
      for (final rating in [0, 6, -1]) {
        final result = await repo.saveMyCourseFeedback(
          courseId: 'A',
          rating: rating,
          text: '',
        );
        expect(
          result.fold((failure) => failure.message, (_) => 'saved'),
          LocaleKeys.ratingRequired,
        );
      }
      final tooLong = await repo.saveMyCourseFeedback(
        courseId: 'A',
        rating: 5,
        text: 'x' * (maxCourseFeedbackLength + 1),
      );
      expect(
        tooLong.fold((failure) => failure.message, (_) => 'saved'),
        LocaleKeys.ratingErrorTextTooLong,
      );
    });

    test('the length limit counts characters like the server does', () async {
      var calls = 0;
      final repo = _repo(
        invoker: (name, body, token) async {
          calls++;
          return EdgeFunctionResponse(status: 200, data: _savedResponse());
        },
      );
      // 500 emoji are 1000 UTF-16 units but 500 characters: allowed.
      final result = await repo.saveMyCourseFeedback(
        courseId: 'A',
        rating: 5,
        text: '👍' * maxCourseFeedbackLength,
      );
      expect(result.isRight(), isTrue);
      expect(calls, 1);
    });

    test('server error codes become messages for the student', () async {
      final repo = _repo(
        invoker: (name, body, token) async => const EdgeFunctionResponse(
          status: 403,
          data: {
            'ok': false,
            'error': {'code': 'not_subscribed', 'message': 'internal text'},
          },
        ),
      );
      final result = await repo.saveMyCourseFeedback(
        courseId: 'A',
        rating: 5,
        text: '',
      );
      expect(
        result.fold((failure) => failure.message, (_) => 'saved'),
        LocaleKeys.ratingErrorNotSubscribed,
      );
    });

    test('every server code maps to the right message', () {
      final expected = <String, String>{
        'not_subscribed': LocaleKeys.ratingErrorNotSubscribed,
        'own_course': LocaleKeys.ratingErrorNotAllowed,
        'not_student': LocaleKeys.ratingErrorNotAllowed,
        'inactive_user': LocaleKeys.ratingErrorInactiveAccount,
        'course_unavailable': LocaleKeys.ratingErrorCourseUnavailable,
        'too_many_requests': LocaleKeys.ratingErrorTooFast,
        'busy': LocaleKeys.ratingErrorBusy,
        'invalid_rating': LocaleKeys.ratingRequired,
        'text_too_long': LocaleKeys.ratingErrorTextTooLong,
        'feedback_not_found': LocaleKeys.ratingErrorAlreadyDeleted,
        'unauthorized': LocaleKeys.ratingErrorSignIn,
        'authentication_required': LocaleKeys.ratingErrorSignIn,
        'network_error': LocaleKeys.serverConnectionError,
        'network_timeout': LocaleKeys.connectionTimeout,
        'internal_error': LocaleKeys.errorOccurredMessage,
        'something_new': LocaleKeys.errorOccurredMessage,
      };
      expected.forEach((code, message) {
        expect(courseFeedbackErrorMessage(code), message, reason: code);
      });
    });

    test('a malformed success response is an error, not a crash', () async {
      final repo = _repo(
        invoker: (name, body, token) async =>
            const EdgeFunctionResponse(status: 200, data: {'ok': true}),
      );
      final result = await repo.saveMyCourseFeedback(
        courseId: 'A',
        rating: 5,
        text: '',
      );
      expect(
        result.fold((failure) => failure.message, (_) => 'saved'),
        LocaleKeys.errorOccurredMessage,
      );
    });

    test('delete returns the new summary, or null without a course', () async {
      String? sentName;
      Map<String, dynamic>? sentBody;
      var withCourse = true;
      final repo = _repo(
        invoker: (name, body, token) async {
          sentName = name;
          sentBody = body;
          return EdgeFunctionResponse(
            status: 200,
            data: {
              'ok': true,
              'deleted': true,
              'stats': withCourse
                  ? {'ratingsSum': 5, 'ratingsCount': 1, 'feedBacksCount': 1}
                  : null,
            },
          );
        },
      );

      final deleted = await repo.deleteMyCourseFeedback(
        courseId: 'A',
        teacherId: 't1',
      );
      expect(sentName, 'delete-course-feedback');
      expect(sentBody, {'courseId': 'A', 'teacherId': 't1'});
      expect(deleted.getOrElse(() => fail('Failed.'))!.ratingsCount, 1);

      withCourse = false;
      final orphan = await repo.deleteMyCourseFeedback(courseId: 'A');
      expect(orphan.getOrElse(() => fail('Failed.')), isNull);
    });
  });
}
