// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/course_content_changes.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSectionsResonseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class CourseSectionsRepo {
  /// Every section [addCourseSection] saves successfully, from any screen.
  Stream<AddedCourseSection> get addedSections;

  Future<Either<Failure, void>> addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
  });

  Future<Either<Failure, GetCourseSectionsResonseEntity>> getCourseSections({
    required String courseId,
    required bool isPaginate,
  });

  Future<Either<Failure, void>> deleteSection({
    required String courseId,
    required String sectionId,
    required String teacherId,
  });
}
