// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFeedbackReplyEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';

enum ReviewReportReason {
  offensive('offensive'),
  harassment('harassment'),
  spam('spam'),
  personalInfo('personal_info'),
  irrelevant('irrelevant'),
  other('other');

  const ReviewReportReason(this.wireValue);

  final String wireValue;
}

abstract class ReviewModerationRepo {
  Future<Either<Failure, CourseFeedbackReplyEntity>> saveReply({
    required String courseId,
    required CoursefeedbackItemEntity review,
    required String text,
  });

  Future<Either<Failure, void>> deleteReply({
    required String courseId,
    required String reviewUid,
  });

  Future<Either<Failure, void>> reportReview({
    required String courseId,
    required String reviewUid,
    required ReviewReportReason reason,
    String details = '',
  });
}
