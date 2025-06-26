import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

abstract class CourseReportsRepo {
  Future<Either<Failure, List<Coursereportsitementity>>> getCourseReports(
      {required String courseId});
  Future<Either<Failure, void>> addCourseReport(
      {required String courseId,
      required Coursereportsitementity reportEntity});
}
