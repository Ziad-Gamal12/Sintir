import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';

abstract class Addcoursesectionrepo {
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<Coursetestquestionentity> questions});
  Future<Either<Failure, void>> addCourseSection({
    required CourseEntity courseEntity,
  });
}
