// ignore_for_file: file_names, duplicate_ignore

// ignore_for_file: file_names

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Coursesrepo {
  Future<Either<Failure, void>> addCourse({required CourseEntity courseEntity});
  Future<Either<Failure, List<CourseEntity>>> getRecentCourses();
  Future<Either<Failure, List<CourseEntity>>> getPopularCourses();

  Future<Either<Failure, String>> uplaodFile({required File file});
  Future<Either<Failure, List<CourseEntity>>> getMyCourses();
  Future<Either<Failure, void>> updateCourse(
      {required CourseEntity courseEntity});
}
