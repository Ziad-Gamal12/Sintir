// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/CourseReviewsQuery.dart';

abstract class TeacherCourseReviewsRepo {
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getReviews({
    required String courseId,
    required CourseReviewsQuery query,
    required bool isPaginate,
  });

  Future<Either<Failure, CourseRatingStatsEntity>> getRatingStats({
    required String courseId,
  });

  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getReviewsSince({
    required String courseId,
    required DateTime since,
  });

  DateTime? lastSeenAt(String courseId);

  Future<void> markSeen(String courseId, DateTime at);
}
