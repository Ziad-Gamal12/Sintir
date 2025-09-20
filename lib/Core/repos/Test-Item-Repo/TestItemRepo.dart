// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Testitemrepo {
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<CourseTestQuestionEntity> questions});
  Future<Either<Failure, void>> addTestResult(
      {required TestresulteEntity testResult,
      required String courseId,
      required String sectionId,
      required String sectionItemId});
}
