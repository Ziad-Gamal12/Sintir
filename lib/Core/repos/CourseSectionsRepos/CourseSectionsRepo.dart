// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class CourseSectionsRepo {
  Future<Either<Failure, void>> addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
  });

  Future<Either<Failure, List<CourseSectionEntity>>> getCourseSections(
      {required String courseId});
  // SectionItemsActionsRepo
  Future<Either<Failure, void>> addSectionItem({
    required sectionItem,
    required String courseId,
    required String sectionId,
  });
  // SectionItemsActionsRepo
  Future<Either<Failure, List>> getSectionsItems(
      {required String courseId, required String sectionId});
}
