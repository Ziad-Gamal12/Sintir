// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/ReviewModerationRepo/ReviewModerationRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFeedbackReplyEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/locale_keys.dart';

class ReviewModerationRepoImpl implements ReviewModerationRepo {
  ReviewModerationRepoImpl({
    required this.databaseservice,
    required this.currentUserId,
    required this.currentUserRole,
    DateTime Function()? clock,
  }) : _clock = clock ?? DateTime.now;

  final DataBaseService databaseservice;
  final String Function() currentUserId;
  final String Function() currentUserRole;
  final DateTime Function() _clock;

  static const int maxDetailsLength = 1000;

  FireStoreRequirmentsEntity _feedback(String courseId, String reviewUid) =>
      FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollection: BackendEndpoints.feedBacksSubCollection,
        subDocId: reviewUid,
      );

  static String? validateReply(String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty) return LocaleKeys.reviewReplyEmpty;
    if (trimmed.length > CourseFeedbackReplyEntity.maxLength) {
      return LocaleKeys.reviewReplyTooLong;
    }
    return null;
  }

  static Map<String, dynamic> replyWrite({
    required String text,
    required String authorId,
    required bool isNew,
  }) {
    final field = BackendEndpoints.teacherReplyField;
    if (isNew) {
      return {
        field: {
          'text': text,
          'authorId': authorId,
          'createdAt': FieldValue.serverTimestamp(),
          'updatedAt': FieldValue.serverTimestamp(),
        },
      };
    }
    return {
      '$field.text': text,
      '$field.updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static String reportId({
    required String courseId,
    required String reviewUid,
    required String reporterUid,
  }) => '${courseId}_${reviewUid}_$reporterUid';

  @override
  Future<Either<Failure, CourseFeedbackReplyEntity>> saveReply({
    required String courseId,
    required CoursefeedbackItemEntity review,
    required String text,
  }) async {
    final invalid = validateReply(text);
    if (invalid != null) return left(ServerFailure(message: invalid));
    final trimmed = text.trim();
    final existing = review.teacherReply;
    try {
      await databaseservice.updateData(
        requirements: _feedback(courseId, review.uid),
        data: replyWrite(
          text: trimmed,
          authorId: currentUserId(),
          isNew: existing == null,
        ),
      );
      final now = _clock();
      return right(
        CourseFeedbackReplyEntity(
          text: trimmed,
          authorId: currentUserId(),
          createdAt: existing?.createdAt ?? now,
          updatedAt: now,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> deleteReply({
    required String courseId,
    required String reviewUid,
  }) async {
    try {
      await databaseservice.updateData(
        requirements: _feedback(courseId, reviewUid),
        data: {BackendEndpoints.teacherReplyField: FieldValue.delete()},
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> reportReview({
    required String courseId,
    required String reviewUid,
    required ReviewReportReason reason,
    String details = '',
  }) async {
    final reporter = currentUserId();
    if (reporter == reviewUid) {
      return left(ServerFailure(message: LocaleKeys.reviewReportOwn));
    }
    final trimmed = details.trim();
    if (trimmed.length > maxDetailsLength) {
      return left(ServerFailure(message: LocaleKeys.reviewReportTooLong));
    }
    final id = reportId(
      courseId: courseId,
      reviewUid: reviewUid,
      reporterUid: reporter,
    );
    final requirements = FireStoreRequirmentsEntity(
      collection: BackendEndpoints.reviewReportsCollection,
      docId: id,
    );
    try {
      final existing = await databaseservice.getData(
        requirements: requirements,
      );
      if (existing.docData != null) {
        return left(ServerFailure(message: LocaleKeys.reviewReportAlreadySent));
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
    try {
      await databaseservice.setData(
        requirements: requirements,
        data: {
          'courseId': courseId,
          'reviewUid': reviewUid,
          'reportedBy': reporter,
          'reporterRole': currentUserRole(),
          'reason': reason.wireValue,
          'details': trimmed,
          'status': 'open',
          'createdAt': FieldValue.serverTimestamp(),
        },
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}
