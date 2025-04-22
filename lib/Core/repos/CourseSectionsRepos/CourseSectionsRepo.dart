// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseSectionEntity.dart';

abstract class CourseSectionsRepo {
  Future<Either<Failure, void>> addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
    required sectionItem,
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
