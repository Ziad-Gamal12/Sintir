import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/MyMistakes/Domain/Entities/GetMyMistakesResponseEntity.dart';

abstract class MyMistakesRepo {
  Future<Either<Failure, GetMyMistakesResponseEntity>> getMyMistakes(
      {required String userUID, required bool isPaginate});
  Future<Either<Failure, void>> storeTestMyMistakesExamResult(
      {required TestResultEntity testResult, required String userUID});
}
