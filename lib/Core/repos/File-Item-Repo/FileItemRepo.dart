import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';

abstract class FileItemRepo {
  Future<Either<Failure, String>> uploadFile({
    required CourseFileEntity coursefileEntity,
  });
}
