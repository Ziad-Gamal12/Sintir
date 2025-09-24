// ignore_for_file: file_names, duplicate_ignore

// ignore_for_file: file_names

import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/GetCourseResonseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class Coursesrepo {
  Future<Either<Failure, void>> addCourse({required CourseEntity courseEntity});
  Future<Either<Failure, GetCoursesResonseEntity>> getRecentCourses(
      {required bool isPaginate});
  Future<Either<Failure, GetCoursesResonseEntity>> getPopularCourses(
      {required bool isPaginate});

  Future<Either<Failure, String>> uplaodFile({required File file});
  Future<Either<Failure, GetCoursesResonseEntity>> getMyCourses(
      {required bool isPaginate});
  Future<Either<Failure, void>> updateCourse(
      {required CourseEntity courseEntity});
}
