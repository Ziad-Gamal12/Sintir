import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class AiTeacherRepo {
  Future<Either<Failure, String>> extractTextFromFile();
}
