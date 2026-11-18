// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseRatingStatsEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/CourseFeedbackSaveResult.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/course_feedback_error_messages.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseFedBacksModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseFeedBacksRepoImpli implements CourseFeedBacksRepo {
  CourseFeedBacksRepoImpli({
    required this.databaseservice,
    required this.edgeFunctions,
  });

  final DataBaseService databaseservice;
  final EdgeFunctionsService edgeFunctions;

  static const int pageSize = 10;
  static const String upsertFunction = 'upsert-course-feedback';
  static const String deleteFunction = 'delete-course-feedback';

  final Map<String, DocumentSnapshot<Object?>> _lastDocs = {};

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getCourseFedBacks({
    required String courseId,
    required bool isPaginate,
  }) async {
    try {
      final cursor = isPaginate ? _lastDocs[courseId] : null;
      if (isPaginate && cursor == null) {
        return right(
          GetCourseFeedBacksResponseEntity(
            feedBacks: [],
            hasMore: false,
            isPaginate: true,
          ),
        );
      }

      final FireStoreResponse response = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.feedBacksSubCollection,
        ),
        query: {
          "orderBy": "datePosted",
          "descending": true,
          "limit": pageSize,
          "startAfter": cursor,
        },
      );

      final rawList = response.listData;
      if (rawList == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      final lastDoc = response.lastDocumentSnapshot;
      if (lastDoc != null) {
        _lastDocs[courseId] = lastDoc;
      } else if (!isPaginate) {
        _lastDocs.remove(courseId);
      }

      return right(
        GetCourseFeedBacksResponseEntity(
          feedBacks: parseCourseFeedbacks(rawList),
          hasMore: response.hasMore ?? false,
          isPaginate: isPaginate,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity>> getCourseRatingStats({
    required String courseId,
  }) async {
    try {
      final response = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
        ),
      );
      final course = response.docData;
      if (course == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      return right(CourseRatingStatsEntity.fromJson(course));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, CoursefeedbackItemEntity?>> getMyCourseFeedback({
    required String courseId,
    required String uid,
  }) async {
    try {
      final response = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.feedBacksSubCollection,
          subDocId: uid,
        ),
      );
      final doc = response.docData;
      if (doc == null) return right(null);
      return right(Coursefeedbacksmodel.fromJson(doc).toEntity());
    } on FormatException {
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, CourseFeedbackSaveResult>> saveMyCourseFeedback({
    required String courseId,
    required int rating,
    required String text,
    String? teacherId,
  }) async {
    if (rating < 1 || rating > 5) {
      return left(ServerFailure(message: LocaleKeys.ratingRequired));
    }
    final trimmed = text.trim();
    if (trimmed.runes.length > maxCourseFeedbackLength) {
      return left(ServerFailure(message: LocaleKeys.ratingErrorTextTooLong));
    }

    try {
      final data = await edgeFunctions.invoke(upsertFunction, {
        'courseId': courseId,
        'rating': rating,
        'text': trimmed,
        if (teacherId != null && teacherId.isNotEmpty) 'teacherId': teacherId,
      });
      final feedback = data['feedback'];
      final stats = data['stats'];
      if (feedback is! Map || stats is! Map) {
        return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
      }
      return right(
        CourseFeedbackSaveResult(
          feedback: Coursefeedbacksmodel.fromJson(
            Map<String, dynamic>.from(feedback),
          ).toEntity(),
          stats: CourseRatingStatsEntity.fromJson(
            Map<String, dynamic>.from(stats),
          ),
          created: data['created'] == true,
        ),
      );
    } on EdgeFunctionException catch (e) {
      return left(ServerFailure(message: courseFeedbackErrorMessage(e.code)));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, CourseRatingStatsEntity?>> deleteMyCourseFeedback({
    required String courseId,
    String? teacherId,
  }) async {
    try {
      final data = await edgeFunctions.invoke(deleteFunction, {
        'courseId': courseId,
        if (teacherId != null && teacherId.isNotEmpty) 'teacherId': teacherId,
      });
      final stats = data['stats'];
      return right(
        stats is Map
            ? CourseRatingStatsEntity.fromJson(Map<String, dynamic>.from(stats))
            : null,
      );
    } on EdgeFunctionException catch (e) {
      return left(ServerFailure(message: courseFeedbackErrorMessage(e.code)));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

List<CoursefeedbackItemEntity> parseCourseFeedbacks(List<dynamic> rawList) {
  final results = <CoursefeedbackItemEntity>[];
  for (final item in rawList) {
    if (item is! Map) continue;
    try {
      results.add(
        Coursefeedbacksmodel.fromJson(
          Map<String, dynamic>.from(item),
        ).toEntity(),
      );
    } on FormatException {
      continue;
    }
  }
  return results;
}
