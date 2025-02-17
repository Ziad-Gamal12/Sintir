import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Coursesrepo {
  Future<Either<Failure, void>> addCourse({required CourseEntity courseEntity});
  Future<Either<Failure, List<CourseEntity>>> getRecentCourses();
  Future<Either<Failure, List<CourseEntity>>> getPopularCourses();

  Future<Either<Failure, String>> uplaodFile({required File file});
}
