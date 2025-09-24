import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/GetCourseReportsResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

abstract class CourseReportsRepo {
  Future<Either<Failure, GetCourseReportsResponseEntity>> getCourseReports(
      {required String courseId, required bool isPaginate});
  Future<Either<Failure, void>> addCourseReport(
      {required String courseId, required CourseReportEntity reportEntity});
}
