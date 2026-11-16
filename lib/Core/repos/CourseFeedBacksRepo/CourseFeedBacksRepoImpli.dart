// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart'; // compute
import 'package:sintir/Core/Enums/courseCounterField.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseCountersRepo/CourseCountersRepo.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseFedBacksModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CoursefedbackItemEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseFeedBacksRepoImpli implements CourseFeedBacksRepo {
  final DataBaseService databaseservice;
  final CourseCountersRepo courseCountersRepo;
  CourseFeedBacksRepoImpli({
    required this.databaseservice,
    required this.courseCountersRepo,
  });

  @override
  Future<Either<Failure, void>> addCourseFedBack({
    required String courseId,
    required String teacherId,
    required CoursefeedbackItemEntity review,
  }) async {
    try {
      final Map<String, dynamic> json = Coursefeedbacksmodel.fromEntity(
        coursefedbackItemEntity: review,
      ).toJson();

      final feedbackDocReq = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollection: BackendEndpoints.feedBacksSubCollection,
        subDocId: review.uid,
      );

      final bool alreadyReviewed = await databaseservice.isDataExists(
        key: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollectionKey: BackendEndpoints.feedBacksSubCollection,
        subDocId: review.uid,
      );

      await Future.wait([
        databaseservice.setData(data: json, requirements: feedbackDocReq),
        if (!alreadyReviewed)
          courseCountersRepo.updateCourseCounters(
            courseId: courseId,
            teacherId: teacherId,
            field: CourseCounterField.feedbacks,
            delta: 1,
          ),
      ]);

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  DocumentSnapshot? _getCourseFeedBacksLastDoc;

  final Map<String, dynamic> _baseGetCourseFeedBacksQuery = {
    "startAfter": null,
    "limit": 10,
  };

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getCourseFedBacks({
    required String courseId,
    required bool isPaginate,
  }) async {
    try {
      final Map<String, dynamic> query = Map<String, dynamic>.from(
        _baseGetCourseFeedBacksQuery,
      );
      query["startAfter"] = isPaginate == true
          ? _getCourseFeedBacksLastDoc
          : null;
      final FireStoreResponse response = await databaseservice.getData(
        query: query,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.feedBacksSubCollection,
        ),
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      if (response.listData!.isEmpty) {
        return right(
          GetCourseFeedBacksResponseEntity(
            feedBacks: [],
            hasMore: false,
            isPaginate: isPaginate,
          ),
        );
      }

      if (response.lastDocumentSnapshot != null) {
        _getCourseFeedBacksLastDoc = response.lastDocumentSnapshot;
      }
      final List<CoursefeedbackItemEntity> courseReviews =
          await compute<
            List<Map<String, dynamic>>,
            List<CoursefeedbackItemEntity>
          >(
            _parseCourseFeedbacks,
            response.listData as List<Map<String, dynamic>>,
          );

      final bool hasMore = response.hasMore ?? false;

      return right(
        GetCourseFeedBacksResponseEntity(
          feedBacks: courseReviews,
          hasMore: hasMore,
          isPaginate: isPaginate,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

List<CoursefeedbackItemEntity> _parseCourseFeedbacks(
  List<Map<String, dynamic>> rawList,
) {
  final List<CoursefeedbackItemEntity> results = [];
  for (final Map<String, dynamic> item in rawList) {
    try {
      final CoursefeedbackItemEntity entity = Coursefeedbacksmodel.fromJson(
        item,
      ).toEntity();
      results.add(entity);
    } catch (e) {
      throw CustomException(message: LocaleKeys.unexpectedError);
    }
  }
  return results;
}
