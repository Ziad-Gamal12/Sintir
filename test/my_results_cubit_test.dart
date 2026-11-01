import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/MyResults/Domain/Entities/get_my_results_response_entity.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/my_results_repo.dart';
import 'package:sintir/Features/MyResults/Presentation/Manager/cubit/my_results_cubit.dart';

void main() {
  group('MyResultsCubit', () {
    test('refresh waits for an active page and suppresses its stale result',
        () async {
      final repo = _FakeMyResultsRepo();
      final cubit = MyResultsCubit(myResultsRepo: repo);
      await cubit.getMyResults(userId: 'student', isPaginate: false);
      final emitted = <MyResultsState>[];
      final subscription = cubit.stream.listen(emitted.add);
      final page = Completer<Either<Failure, GetMyResultsResponseEntity>>();
      final refresh = Completer<Either<Failure, GetMyResultsResponseEntity>>();
      repo.responses.add(page.future);
      repo.responses.add(refresh.future);

      final pageRequest =
          cubit.getMyResults(userId: 'student', isPaginate: true);
      final refreshRequest =
          cubit.getMyResults(userId: 'student', isPaginate: false);
      expect(repo.requests, hasLength(2));

      page.complete(Right(_response(
          isPaginate: true, totalCount: 25, average: 74, hasMore: true)));
      await pageRequest;
      await Future<void>.delayed(Duration.zero);
      expect(repo.requests, hasLength(3));
      expect(
          emitted
              .whereType<GetMyResultsSuccess>()
              .any((state) => state.getMyResultsResponseEntity.isPaginate),
          isFalse);

      refresh.complete(Right(_response(
          isPaginate: false, totalCount: 25, average: 76, hasMore: true)));
      await refreshRequest;
      expect(cubit.state, isA<GetMyResultsSuccess>());
      expect((cubit.state as GetMyResultsSuccess).overallAveragePercent, 76);

      await subscription.cancel();
      await cubit.close();
    });

    test('exposes full collection summary and blocks concurrent page loads',
        () async {
      final repo = _FakeMyResultsRepo();
      final firstPage =
          Completer<Either<Failure, GetMyResultsResponseEntity>>();
      repo.responses.add(firstPage.future);
      final cubit = MyResultsCubit(myResultsRepo: repo);

      final initialFetch =
          cubit.getMyResults(userId: 'student', isPaginate: false);
      await cubit.getMyResults(userId: 'student', isPaginate: true);
      expect(repo.requests, [(userId: 'student', isPaginate: false)]);

      firstPage.complete(Right(_response(
          isPaginate: false, totalCount: 25, average: 74, hasMore: true)));
      await initialFetch;
      final state = cubit.state as GetMyResultsSuccess;
      expect(state.totalCount, 25);
      expect(state.overallAveragePercent, 74);
      expect(state.hasMore, isTrue);

      await cubit.getMyResults(userId: 'student', isPaginate: true);
      expect(repo.requests.last.isPaginate, isTrue);
      repo.responses.add(Future.value(Right(_response(
          isPaginate: false, totalCount: 25, average: 74, hasMore: false))));
      await cubit.getMyResults(userId: 'student', isPaginate: false);
      expect(repo.requests.last.isPaginate, isFalse);
      final requestCount = repo.requests.length;
      await cubit.getMyResults(userId: 'student', isPaginate: true);
      expect(repo.requests, hasLength(requestCount));
      await cubit.close();
    });

    test(
        'keeps accumulated results in cubit state and replaces them on refresh',
        () async {
      final repo = _FakeMyResultsRepo();
      final cubit = MyResultsCubit(myResultsRepo: repo);
      final first = TestResultEntity.empty();
      final second = TestResultEntity.empty();
      repo.responses.add(Future.value(Right(_response(
          isPaginate: false,
          totalCount: 2,
          average: 60,
          hasMore: true,
          results: [first]))));
      await cubit.getMyResults(userId: 'student', isPaginate: false);
      repo.responses.add(Future.value(Right(_response(
          isPaginate: true,
          totalCount: 2,
          average: 60,
          hasMore: false,
          results: [second]))));
      await cubit.getMyResults(userId: 'student', isPaginate: true);
      expect((cubit.state as GetMyResultsSuccess).results, [first, second]);

      repo.responses.add(Future.value(Right(_response(
          isPaginate: false,
          totalCount: 1,
          average: 82,
          hasMore: false,
          results: [second]))));
      await cubit.getMyResults(userId: 'student', isPaginate: false);
      final refreshed = cubit.state as GetMyResultsSuccess;
      expect(refreshed.results, [second]);
      expect(refreshed.overallAveragePercent, 82);
      await cubit.close();
    });
  });
}

GetMyResultsResponseEntity _response(
        {required bool isPaginate,
        required int totalCount,
        required int average,
        required bool hasMore,
        List<TestResultEntity> results = const []}) =>
    GetMyResultsResponseEntity(
      results: results,
      isPaginate: isPaginate,
      totalCount: totalCount,
      overallAveragePercent: average,
      hasMore: hasMore,
    );

class _FakeMyResultsRepo implements MyResultsRepo {
  final List<({String userId, bool isPaginate})> requests = [];
  final List<Future<Either<Failure, GetMyResultsResponseEntity>>> responses =
      [];

  @override
  Future<Either<Failure, GetMyResultsResponseEntity>> getMyResults(
      {required String userId, required bool isPaginate}) {
    requests.add((userId: userId, isPaginate: isPaginate));
    if (responses.isNotEmpty) return responses.removeAt(0);
    return Future.value(Right(_response(
        isPaginate: isPaginate, totalCount: 25, average: 74, hasMore: true)));
  }

  @override
  void invalidateOverviewCache({required String userId}) {}
}
