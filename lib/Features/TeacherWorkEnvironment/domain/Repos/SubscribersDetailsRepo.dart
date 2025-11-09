import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class SubscribersDetailsRepo {
  Future<Either<Failure, List<TestResultEntity>>> getSubscriberResults(
      {required String subscriberId, required String courseId});
  Future<Either<Failure, TestResultEntity>> getSubscriberHighestScore(
      {required String subscriberId, required String courseId});
  Future<Either<Failure, TestResultEntity>> getSubscriberLowestScore(
      {required String subscriberId, required String courseId});
  Future<Either<Failure, List<CourseEntity>>>
      getSubscibersEnrolledCoursesForTeacher(
          {required String contentCreatorId, required String subscriberId});
}
