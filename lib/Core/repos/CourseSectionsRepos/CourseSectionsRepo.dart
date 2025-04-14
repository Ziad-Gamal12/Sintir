// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

abstract class CourseSectionsRepo {
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<Coursetestquestionentity> questions});

  Future<Either<Failure, void>> addCourseSection({
    required CourseSectionEntity section,
    required String courseId,
  });
  Future<Either<Failure, String>> uploadVideo({
    required Coursevedioitementity coursevedioitementity,
  });
  Future<Either<Failure, String>> uploadFile({
    required Coursefileentity coursefileEntity,
  });
  Future<Either<Failure, List<CourseSectionEntity>>> getCourseSections(
      {required String courseId});
}
