// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCourseActivity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherCoursesQuery.dart';

abstract class TeacherWorkspaceRepo {
  Future<Either<Failure, List<CourseEntity>>> getCourses({
    required String teacherId,
  });

  Future<Either<Failure, TeacherCourseActivity>> getCourseActivity({
    required CourseEntity course,
    required DateTime now,
  });

  TeacherCoursesSort savedSort();

  Future<void> saveSort(TeacherCoursesSort sort);
}
