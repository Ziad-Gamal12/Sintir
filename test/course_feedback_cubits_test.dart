import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/CourseFeedBacksCubit/course_feed_backs_cubit.dart';
import 'package:sintir/Core/Managers/Cubits/MyCourseRatingCubit/my_course_rating_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseFeedbackSaveResult.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

class _FakeRepo implements CourseFeedBacksRepo {
  final List<bool> pageRequests = [];
  final List<Completer<Either<Failure, GetCourseFeedBacksResponseEntity>>>
  pages = [];
  Either<Failure, CourseRatingStatsEntity> stats = right(
    const CourseRatingStatsEntity(),
  );
  Completer<void>? statsGate;
  int statsCalls = 0;
  Either<Failure, CoursefeedbackItemEntity?> myFeedback = right(null);
  Either<Failure, CourseFeedbackSaveResult>? saveResult;
  Either<Failure, CourseRatingStatsEntity?>? deleteResult;
  final List<Map<String, Object?>> saveCalls = [];
  int deleteCalls = 0;
  String? myFeedbackUid;

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getCourseFedBacks({
    required String courseId,
    required bool isPaginate,
  }) {
    pageRequests.add(isPaginate);
    final page = Completer<Either<Failure, GetCourseFeedBacksResponseEntity>>();
    pages.add(page);
    return page.future;
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity>> getCourseRatingStats({
    required String courseId,
  }) async {
    statsCalls++;
    final result = stats;
    await statsGate?.future;
    return result;
  }

  @override
  Future<Either<Failure, CoursefeedbackItemEntity?>> getMyCourseFeedback({
    required String courseId,
    required String uid,
  }) async {
    myFeedbackUid = uid;
    return myFeedback;
  }

  @override
  Future<Either<Failure, CourseFeedbackSaveResult>> saveMyCourseFeedback({
    required String courseId,
    required int rating,
    required String text,
    String? teacherId,
  }) async {
    saveCalls.add({
      'courseId': courseId,
      'rating': rating,
      'text': text,
      'teacherId': teacherId,
    });
    return saveResult!;
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity?>> deleteMyCourseFeedback({
    required String courseId,
    String? teacherId,
  }) async {
    deleteCalls++;
    return deleteResult!;
  }
}

CoursefeedbackItemEntity _review(String uid, {int? rating = 5, String text = ''}) {
  return CoursefeedbackItemEntity(
    userImage: '',
    name: uid,
    uid: uid,
    fedBack: text,
    datePosted: DateTime(2026, 11, 1),
    rating: rating,
  );
}

GetCourseFeedBacksResponseEntity _page(
  List<String> uids, {
  required bool isPaginate,
  bool hasMore = true,
}) {
  return GetCourseFeedBacksResponseEntity(
    feedBacks: [for (final uid in uids) _review(uid)],
    hasMore: hasMore,
    isPaginate: isPaginate,
  );
}

/// Lets queued stream events reach their listeners.
Future<void> _settle() => Future<void>.delayed(Duration.zero);

void main() {
  group('CourseFeedBacksCubit', () {
    test('one page at a time, no duplicates, stops at the last page', () async {
      final repo = _FakeRepo();
      final cubit = CourseFeedBacksCubit(courseFeedBacksRepo: repo);

      final first = cubit.getCourseFeedBacks(
        courseId: 'A',
        isPaginate: false,
      );
      // Ignored: the first page is still loading.
      await cubit.getCourseFeedBacks(courseId: 'A', isPaginate: true);
      expect(repo.pageRequests, [false]);

      repo.pages.single.complete(right(_page(['s1', 's2'], isPaginate: false)));
      await first;

      final second = cubit.getCourseFeedBacks(courseId: 'A', isPaginate: true);
      repo.pages.last.complete(
        right(_page(['s2', 's3'], isPaginate: true, hasMore: false)),
      );
      await second;

      expect(cubit.feedBacks.map((review) => review.uid).toList(), [
        's1',
        's2',
        's3',
      ]);
      expect(cubit.hasMore, isFalse);

      await cubit.getCourseFeedBacks(courseId: 'A', isPaginate: true);
      expect(repo.pageRequests, [false, true]);
      await cubit.close();
    });

    test('saved and deleted reviews update the list without reloading', () async {
      final repo = _FakeRepo();
      final cubit = CourseFeedBacksCubit(courseFeedBacksRepo: repo);
      final load = cubit.getCourseFeedBacks(courseId: 'A', isPaginate: false);
      repo.pages.single.complete(right(_page(['s1', 's2'], isPaginate: false)));
      await load;

      cubit.upsertLocally(_review('s2', rating: 1, text: 'edited'));
      expect(cubit.feedBacks.map((review) => review.uid).toList(), ['s1', 's2']);
      expect(cubit.feedBacks[1].fedBack, 'edited');

      cubit.upsertLocally(_review('me', rating: 4));
      expect(cubit.feedBacks.first.uid, 'me');

      cubit.removeLocally('me');
      expect(cubit.feedBacks.map((review) => review.uid).toList(), ['s1', 's2']);
      expect(repo.pageRequests, [false]);

      final emitted =
          (cubit.state as CourseFeedBacksGetFeedBackSuccess).response.feedBacks;
      emitted.add(_review('x')); // listeners may extend the emitted list…
      expect(cubit.feedBacks.length, 2); // …without touching the cubit's own
      await cubit.close();
    });

    test('a failed next page keeps the loaded reviews', () async {
      final repo = _FakeRepo();
      final cubit = CourseFeedBacksCubit(courseFeedBacksRepo: repo);
      final load = cubit.getCourseFeedBacks(courseId: 'A', isPaginate: false);
      repo.pages.single.complete(right(_page(['s1'], isPaginate: false)));
      await load;

      final next = cubit.getCourseFeedBacks(courseId: 'A', isPaginate: true);
      expect(
        cubit.state,
        isA<CourseFeedBacksGetFeedBackLoading>().having(
          (state) => state.isPaginate,
          'isPaginate',
          isTrue,
        ),
      );
      repo.pages.last.complete(left(ServerFailure(message: 'offline')));
      await next;

      expect(
        cubit.state,
        isA<CourseFeedBacksGetFeedBackFailure>().having(
          (state) => state.isPaginate,
          'isPaginate',
          isTrue,
        ),
      );
      expect(cubit.feedBacks.map((review) => review.uid).toList(), ['s1']);
      await cubit.close();
    });

    test('hasLoadedOnce turns true once the first page answers', () async {
      final repo = _FakeRepo();
      final cubit = CourseFeedBacksCubit(courseFeedBacksRepo: repo);
      expect(cubit.hasLoadedOnce, isFalse);

      final load = cubit.getCourseFeedBacks(courseId: 'A', isPaginate: false);
      expect(cubit.hasLoadedOnce, isFalse);
      repo.pages.single.complete(left(ServerFailure(message: 'offline')));
      await load;
      // An error also ends the first load: the screen shows it with retry.
      expect(cubit.hasLoadedOnce, isTrue);
      await cubit.close();
    });

    test('refresh keeps the reviews on screen and keeps them on failure', () async {
      final repo = _FakeRepo();
      final cubit = CourseFeedBacksCubit(courseFeedBacksRepo: repo);
      final load = cubit.getCourseFeedBacks(courseId: 'A', isPaginate: false);
      repo.pages.single.complete(right(_page(['s1', 's2'], isPaginate: false)));
      await load;

      final states = <CourseFeedBacksState>[];
      final subscription = cubit.stream.listen(states.add);
      final failed = cubit.refresh(courseId: 'A');
      expect(repo.pageRequests, [false, false]);
      repo.pages.last.complete(left(ServerFailure(message: 'offline')));
      await failed;
      await _settle();
      // No loading state: the list never blanks out while refreshing.
      expect(states, [isA<CourseFeedBacksGetFeedBackFailure>()]);
      expect(cubit.feedBacks.map((review) => review.uid).toList(), ['s1', 's2']);

      final refreshed = cubit.refresh(courseId: 'A');
      repo.pages.last.complete(
        right(_page(['s3', 's1'], isPaginate: false, hasMore: false)),
      );
      await refreshed;
      expect(cubit.feedBacks.map((review) => review.uid).toList(), ['s3', 's1']);
      expect(cubit.hasMore, isFalse);
      await subscription.cancel();
      await cubit.close();
    });

    test('a refresh while a page is loading is ignored', () async {
      final repo = _FakeRepo();
      final cubit = CourseFeedBacksCubit(courseFeedBacksRepo: repo);
      final load = cubit.getCourseFeedBacks(courseId: 'A', isPaginate: false);
      await cubit.refresh(courseId: 'A');
      expect(repo.pageRequests, [false]);
      repo.pages.single.complete(right(_page(['s1'], isPaginate: false)));
      await load;
      await cubit.close();
    });
  });

  group('MyCourseRatingCubit', () {
    MyCourseRatingCubit cubitFor(_FakeRepo repo) => MyCourseRatingCubit(
      courseFeedBacksRepo: repo,
      courseId: 'A',
      teacherId: 't1',
    );

    test('loads the summary and my review together', () async {
      final repo = _FakeRepo()
        ..stats = right(
          const CourseRatingStatsEntity(ratingsSum: 9, ratingsCount: 2),
        )
        ..myFeedback = right(_review('me', rating: 4, text: 'good'));
      final cubit = cubitFor(repo);
      final states = <MyCourseRatingState>[];
      final subscription = cubit.stream.listen(states.add);

      await cubit.load(uid: 'me');
      await _settle();

      expect(states.map((state) => state.loadStatus).toList(), [
        CourseRatingLoadStatus.loading,
        CourseRatingLoadStatus.loaded,
      ]);
      expect(cubit.state.stats.average, 4.5);
      expect(cubit.state.myFeedback!.fedBack, 'good');
      expect(cubit.state.hasMyRating, isTrue);
      expect(repo.myFeedbackUid, 'me');
      await subscription.cancel();
      await cubit.close();
    });

    test('without a uid only the summary is loaded', () async {
      final repo = _FakeRepo();
      final cubit = cubitFor(repo);
      await cubit.load();
      expect(repo.myFeedbackUid, isNull);
      expect(cubit.state.loadStatus, CourseRatingLoadStatus.loaded);
      expect(cubit.state.myFeedback, isNull);
      await cubit.close();
    });

    test('if only my review fails, the summary still shows', () async {
      final repo = _FakeRepo()
        ..myFeedback = left(ServerFailure(message: 'offline'));
      final cubit = cubitFor(repo);
      await cubit.load(uid: 'me');
      expect(cubit.state.loadStatus, CourseRatingLoadStatus.loaded);
      expect(cubit.state.myFeedback, isNull);
      await cubit.close();
    });

    test('a failed summary keeps its message', () async {
      final repo = _FakeRepo()..stats = left(ServerFailure(message: 'offline'));
      final cubit = cubitFor(repo);
      await cubit.load(uid: 'me');
      expect(cubit.state.loadStatus, CourseRatingLoadStatus.failure);
      expect(cubit.state.errorMessage, 'offline');
      await cubit.close();
    });

    test('save: saving then saved, with the server result', () async {
      final repo = _FakeRepo()
        ..saveResult = right(
          CourseFeedbackSaveResult(
            feedback: _review('me', rating: 5, text: 'great'),
            stats: const CourseRatingStatsEntity(
              ratingsSum: 5,
              ratingsCount: 1,
              distribution: {5: 1},
            ),
            created: true,
          ),
        );
      final cubit = cubitFor(repo);
      final actions = <CourseRatingAction>[];
      final subscription = cubit.stream.listen(
        (state) => actions.add(state.action),
      );

      await cubit.save(rating: 5, text: 'great');
      await _settle();

      expect(actions, [CourseRatingAction.saving, CourseRatingAction.saved]);
      expect(cubit.state.myFeedback!.rating, 5);
      expect(cubit.state.stats.ratingsCount, 1);
      expect(repo.saveCalls.single, {
        'courseId': 'A',
        'rating': 5,
        'text': 'great',
        'teacherId': 't1',
      });
      await subscription.cancel();
      await cubit.close();
    });

    test('a failed save keeps the old review and exposes the message', () async {
      final repo = _FakeRepo()
        ..myFeedback = right(_review('me', rating: 3, text: 'ok'))
        ..saveResult = left(ServerFailure(message: 'wait a bit'));
      final cubit = cubitFor(repo);
      await cubit.load(uid: 'me');
      await cubit.save(rating: 5, text: 'better');
      expect(cubit.state.action, CourseRatingAction.saveFailed);
      expect(cubit.state.errorMessage, 'wait a bit');
      expect(cubit.state.myFeedback!.rating, 3);
      await cubit.close();
    });

    test('a second save while saving is ignored', () async {
      final repo = _FakeRepo()
        ..saveResult = right(
          CourseFeedbackSaveResult(
            feedback: _review('me'),
            stats: const CourseRatingStatsEntity(ratingsSum: 5, ratingsCount: 1),
            created: true,
          ),
        );
      final cubit = cubitFor(repo);
      await Future.wait([
        cubit.save(rating: 5, text: ''),
        cubit.save(rating: 4, text: ''),
      ]);
      expect(repo.saveCalls, hasLength(1));
      await cubit.close();
    });

    test('delete clears my review and updates the summary', () async {
      final repo = _FakeRepo()
        ..myFeedback = right(_review('me', rating: 5))
        ..deleteResult = right(const CourseRatingStatsEntity());
      final cubit = cubitFor(repo);
      await cubit.load(uid: 'me');
      final actions = <CourseRatingAction>[];
      final subscription = cubit.stream.listen(
        (state) => actions.add(state.action),
      );

      await cubit.delete();
      await _settle();

      expect(actions, [CourseRatingAction.deleting, CourseRatingAction.deleted]);
      expect(cubit.state.myFeedback, isNull);
      expect(cubit.state.stats.ratingsCount, 0);
      await subscription.cancel();
      await cubit.close();
    });

    test('delete without a review does nothing', () async {
      final repo = _FakeRepo();
      final cubit = cubitFor(repo);
      await cubit.delete();
      expect(repo.deleteCalls, 0);
      expect(cubit.state.action, CourseRatingAction.idle);
      await cubit.close();
    });

    test('a failed delete keeps the review and signals deleteFailed', () async {
      final repo = _FakeRepo()
        ..myFeedback = right(_review('me', rating: 4))
        ..deleteResult = left(ServerFailure(message: 'offline'));
      final cubit = cubitFor(repo);
      await cubit.load(uid: 'me');
      await cubit.delete();
      expect(cubit.state.action, CourseRatingAction.deleteFailed);
      expect(cubit.state.errorMessage, 'offline');
      expect(cubit.state.myFeedback!.rating, 4);
      await cubit.close();
    });

    test('hasLoadedOnce turns true after the first load, even a failed one', () async {
      final repo = _FakeRepo()..stats = left(ServerFailure(message: 'offline'));
      final cubit = cubitFor(repo);
      expect(cubit.state.hasLoadedOnce, isFalse);
      await cubit.load(uid: 'me');
      expect(cubit.state.hasLoadedOnce, isTrue);

      // A retry shows loading again but never undoes hasLoadedOnce.
      repo.stats = right(const CourseRatingStatsEntity());
      final states = <MyCourseRatingState>[];
      final subscription = cubit.stream.listen(states.add);
      await cubit.load(uid: 'me');
      await _settle();
      expect(states.first.loadStatus, CourseRatingLoadStatus.loading);
      expect(states.every((state) => state.hasLoadedOnce), isTrue);
      expect(cubit.state.loadStatus, CourseRatingLoadStatus.loaded);
      await subscription.cancel();
      await cubit.close();
    });

    test('reloading keeps the summary on screen and keeps it on failure', () async {
      final repo = _FakeRepo()
        ..stats = right(
          const CourseRatingStatsEntity(ratingsSum: 9, ratingsCount: 2),
        );
      final cubit = cubitFor(repo);
      await cubit.load(uid: 'me');

      final states = <MyCourseRatingState>[];
      final subscription = cubit.stream.listen(states.add);
      repo.stats = left(ServerFailure(message: 'offline'));
      await cubit.load(uid: 'me');
      await _settle();

      expect(
        states.map((state) => state.loadStatus),
        everyElement(CourseRatingLoadStatus.loaded),
      );
      expect(cubit.state.stats.ratingsCount, 2);
      await subscription.cancel();
      await cubit.close();
    });

    test('a load while loading joins it instead of reading twice', () async {
      final repo = _FakeRepo()..statsGate = Completer<void>();
      final cubit = cubitFor(repo);
      final first = cubit.load(uid: 'me');
      final second = cubit.load(uid: 'me');
      expect(repo.statsCalls, 1);
      repo.statsGate!.complete();
      await Future.wait([first, second]);
      expect(cubit.state.loadStatus, CourseRatingLoadStatus.loaded);

      // Once finished, a new load reads again.
      repo.statsGate = null;
      await cubit.load(uid: 'me');
      expect(repo.statsCalls, 2);
      await cubit.close();
    });

    test('a reload that overlaps a save does not bring back old data', () async {
      final repo = _FakeRepo()
        ..stats = right(
          const CourseRatingStatsEntity(ratingsSum: 3, ratingsCount: 1),
        )
        ..myFeedback = right(_review('me', rating: 3, text: 'old'));
      final cubit = cubitFor(repo);
      await cubit.load(uid: 'me');

      // The reload reads before the save lands and answers after it.
      repo.statsGate = Completer<void>();
      final reload = cubit.load(uid: 'me');
      repo.saveResult = right(
        CourseFeedbackSaveResult(
          feedback: _review('me', rating: 5, text: 'new'),
          stats: const CourseRatingStatsEntity(ratingsSum: 5, ratingsCount: 1),
          created: false,
        ),
      );
      await cubit.save(rating: 5, text: 'new');
      repo.statsGate!.complete();
      await reload;

      expect(cubit.state.myFeedback!.fedBack, 'new');
      expect(cubit.state.stats.ratingsSum, 5);
      await cubit.close();
    });
  });
}
