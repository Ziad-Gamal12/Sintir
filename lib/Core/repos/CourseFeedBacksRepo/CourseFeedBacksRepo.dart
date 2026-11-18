import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseFeedbackSaveResult.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

abstract class CourseFeedBacksRepo {
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getCourseFedBacks({
    required String courseId,
    required bool isPaginate,
  });

  Future<Either<Failure, CourseRatingStatsEntity>> getCourseRatingStats({
    required String courseId,
  });

  Future<Either<Failure, CoursefeedbackItemEntity?>> getMyCourseFeedback({
    required String courseId,
    required String uid,
  });

  Future<Either<Failure, CourseFeedbackSaveResult>> saveMyCourseFeedback({
    required String courseId,
    required int rating,
    required String text,
    String? teacherId,
  });

  Future<Either<Failure, CourseRatingStatsEntity?>> deleteMyCourseFeedback({
    required String courseId,
    String? teacherId,
  });
}
