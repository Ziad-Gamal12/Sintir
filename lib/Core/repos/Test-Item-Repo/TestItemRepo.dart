// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/GetExamResultsReponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Testitemrepo {
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<CourseTestQuestionEntity> questions});
  Future<Either<Failure, void>> addTestResult(
      {required TestResultEntity testResult,
      required String courseId,
      required String sectionId,
      required String sectionItemId});
  Future<Either<Failure, GetExamResultsReponseEntity>> getTestResults(
      {required String courseId,
      required String sectionId,
      required String examId,
      required bool isPaginate});
  Future<Either<Failure, TestResultEntity>> getHighestScore(
      {required String courseId,
      required String sectionId,
      required String sectionItemId});
  Future<Either<Failure, TestResultEntity>> getLowestScore(
      {required String courseId,
      required String sectionId,
      required String sectionItemId});
  Future<Either<Failure, int>> getAttendedCount(
      {required String courseId,
      required String sectionId,
      required String testId});
  Future<Either<Failure, int>> getSuccessedStudentsCount(
      {required String courseId,
      required String sectionId,
      required String testId});
  Future<Either<Failure, int>> getFailedStudentsCount(
      {required String courseId,
      required String sectionId,
      required String testId});
}
