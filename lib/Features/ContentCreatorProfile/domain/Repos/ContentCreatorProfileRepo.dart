import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class ContentCreatorProfileRepo {
  Future<Either<Failure, List<CourseEntity>>> getContentCreatorCourses(
      {required String userId});
  Future<Either<Failure, List<CourseEntity>>> searchContentCreatorCourses(
      {required String userId, required String keyword});
}
