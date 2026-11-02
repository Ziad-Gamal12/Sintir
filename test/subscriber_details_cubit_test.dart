import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/SubscribersDetailsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/subuscriber_details_cubit/subuscriber_details_cubit.dart';

void main() {
  test('emits loading then success with summary for result data', () async {
    final expected = TestResultEntity.empty();
    final cubit = SubscriberDetailsCubit(
      subscribersDetailsRepo: _Repo(results: right([expected])),
    );
    final states = <SubscriberDetailsState>[];
    final sub = cubit.stream.listen(states.add);
    await cubit.getSubscriberResults(
        subscriberId: 'student', courseId: 'course');
    await Future<void>.delayed(Duration.zero);

    expect(states, hasLength(2));
    expect(states.first, isA<GetSubscriberResultsLoading>());
    final success = states.last as GetSubscriberResultsSuccess;
    expect(success.results, [expected]);
    expect(success.summary.percentages, [0]);
    await sub.cancel();
    await cubit.close();
  });

  test('emits empty success for no result data', () async {
    final cubit = SubscriberDetailsCubit(
      subscribersDetailsRepo: _Repo(results: right([])),
    );
    final states = <SubscriberDetailsState>[];
    final sub = cubit.stream.listen(states.add);
    await cubit.getSubscriberResults(
        subscriberId: 'student', courseId: 'course');
    await Future<void>.delayed(Duration.zero);

    expect(states.first, isA<GetSubscriberResultsLoading>());
    final success = states.last as GetSubscriberResultsSuccess;
    expect(success.results, isEmpty);
    expect(success.summary.percentages, isEmpty);
    await sub.cancel();
    await cubit.close();
  });

  test('emits failure after loading', () async {
    final cubit = SubscriberDetailsCubit(
      subscribersDetailsRepo: _Repo(
        results: left(ServerFailure(message: 'failed')),
      ),
    );
    final states = <SubscriberDetailsState>[];
    final sub = cubit.stream.listen(states.add);
    await cubit.getSubscriberResults(
        subscriberId: 'student', courseId: 'course');
    await Future<void>.delayed(Duration.zero);

    expect(states.first, isA<GetSubscriberResultsLoading>());
    expect((states.last as GetSubscriberResultsFailure).errmessage, 'failed');
    await sub.cancel();
    await cubit.close();
  });
}

class _Repo implements SubscribersDetailsRepo {
  _Repo({required this.results});
  final Either<Failure, List<TestResultEntity>> results;

  @override
  Future<Either<Failure, List<TestResultEntity>>> getSubscriberResults(
          {required String subscriberId, required String courseId}) async =>
      results;

  @override
  Future<Either<Failure, TestResultEntity>> getSubscriberHighestScore(
          {required String subscriberId, required String courseId}) async =>
      right(TestResultEntity.empty());

  @override
  Future<Either<Failure, TestResultEntity>> getSubscriberLowestScore(
          {required String subscriberId, required String courseId}) async =>
      right(TestResultEntity.empty());

  @override
  Future<Either<Failure, List<CourseEntity>>>
      getSubscibersEnrolledCoursesForTeacher(
              {required String contentCreatorId,
              required String subscriberId}) async =>
          right([]);
}
