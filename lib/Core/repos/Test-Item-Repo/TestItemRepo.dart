// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/TestResulteEntity.dart';

abstract class Testitemrepo {
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<Coursetestquestionentity> questions});
  Future<Either<Failure, void>> addTestResult(
      {required TestresulteEntity testResult,
      required String courseId,
      required String sectionId,
      required String sectionItemId});
}
