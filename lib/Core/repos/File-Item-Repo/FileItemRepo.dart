import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFileEntity.dart';

abstract class FileItemRepo {
  Future<Either<Failure, String>> uploadFile({
    required CourseFileEntity coursefileEntity,
  });
}
