import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

abstract class CourseFeedBacksRepo {
  Future<Either<Failure, void>> addCourseFedBack(
      {required String courseId, required CoursefeedbackItemEntity review});
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getCourseFedBacks(
      {required String courseId, required bool isPaginate});
}
