import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';

class _FakeTestRepo implements Testitemrepo {
  final List<String> submissionIds = [];
  final List<Completer<Either<Failure, TestResultEntity>>> pending = [];

  @override
  Future<Either<Failure, TestResultEntity>> submitTestAttempt({
    required String courseId,
    required String sectionId,
    required CourseTestEntity test,
    required String submissionId,
  }) {
    submissionIds.add(submissionId);
    final completer = Completer<Either<Failure, TestResultEntity>>();
    pending.add(completer);
    return completer.future;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Unused implements SectionItemsActionsRepo, MyMistakesRepo, Assetspickerrepo {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

CourseTestEntity _test() => CourseTestEntity(
      durationTime: 10,
      title: 'Quiz',
      questions: [],
      numberOfAttempts: 5,
      showResult: true,
      id: 'test-1',
    );

void main() {
  late _FakeTestRepo repo;
  late TestItemCubit cubit;

  setUp(() {
    repo = _FakeTestRepo();
    final unused = _Unused();
    cubit = TestItemCubit(
      testitemrepo: repo,
      sectionItemsActionsRepo: unused,
      myMistakesRepo: unused,
      assetspickerrepo: unused,
    );
  });

  tearDown(() => cubit.close());

  void submit() => cubit.addTestResults(
        test: _test(),
        courseId: 'course-1',
        courseSubject: 'Math',
        sectionId: 'section-1',
        sectionItemId: 'test-1',
        isCourseExam: true,
        userId: 'student-1',
      );

  test('the timer firing while a submit is in flight sends nothing more',
      () async {
    submit();
    submit();
    expect(repo.submissionIds, hasLength(1));

    repo.pending.single.complete(right(TestResultEntity.empty()));
    await pumpEventQueue();
    expect(cubit.state, isA<AddTestResultSuccess>());
  });

  test('a saved attempt is never submitted again', () async {
    submit();
    repo.pending.single.complete(right(TestResultEntity.empty()));
    await pumpEventQueue();

    submit();
    expect(repo.submissionIds, hasLength(1));
    expect(cubit.state, isA<AddTestResultSuccess>());
  });

  test('a retry after a failure resends the same submission id', () async {
    submit();
    repo.pending.single.complete(left(ServerFailure(message: 'timeout')));
    await pumpEventQueue();
    expect(cubit.state, isA<AddTestResultFailure>());

    submit();
    expect(repo.submissionIds, hasLength(2));
    expect(repo.submissionIds.toSet(), {cubit.submissionId});
  });

  test('each sitting of the exam gets its own submission id', () {
    final unused = _Unused();
    final other = TestItemCubit(
      testitemrepo: repo,
      sectionItemsActionsRepo: unused,
      myMistakesRepo: unused,
      assetspickerrepo: unused,
    );
    expect(other.submissionId, isNot(cubit.submissionId));
    expect(cubit.submissionId, matches(RegExp(r'^[A-Za-z0-9_-]{8,128}$')));
    other.close();
  });
}
