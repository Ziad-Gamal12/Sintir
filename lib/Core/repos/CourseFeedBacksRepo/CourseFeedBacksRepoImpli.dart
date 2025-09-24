// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart'; // compute
import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/entities/GetCourseFeedBacksResponseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseFedBacksModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class CourseFeedBacksRepoImpli implements CourseFeedBacksRepo {
  final Databaseservice databaseservice;

  CourseFeedBacksRepoImpli({required this.databaseservice});

  @override
  Future<Either<Failure, void>> addCourseFedBack({
    required String courseId,
    required CoursefeedbackItemEntity review,
  }) async {
    try {
      final Map<String, dynamic> json =
          Coursefeedbacksmodel.fromEntity(coursefedbackItemEntity: review)
              .toJson();

      await databaseservice.setData(
        data: json,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.feedBacksSubCollection,
          subDocId: review.uid,
        ),
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  DocumentSnapshot? _getCourseFeedBacksLastDoc;

  final Map<String, dynamic> _baseGetCourseFeedBacksQuery = {
    "startAfter": null,
    "orderBy": "likesCount",
    "limit": 10,
  };

  @override
  Future<Either<Failure, GetCourseFeedBacksResponseEntity>> getCourseFedBacks({
    required String courseId,
    required bool isPaginate,
  }) async {
    try {
      final Map<String, dynamic> query =
          Map<String, dynamic>.from(_baseGetCourseFeedBacksQuery);
      query["startAfter"] = isPaginate ? _getCourseFeedBacksLastDoc : null;
      final FireStoreResponse response = await databaseservice.getData(
        query: query,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.feedBacksSubCollection,
        ),
      );

      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
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
      final List<CoursefeedbackItemEntity> courseReviews = await compute<
              List<Map<String, dynamic>>, List<CoursefeedbackItemEntity>>(
          _parseCourseFeedbacks,
          response.listData as List<Map<String, dynamic>>);

      final bool hasMore = response.hasMore ?? false;

      return right(
        GetCourseFeedBacksResponseEntity(
          feedBacks: courseReviews,
          hasMore: hasMore,
          isPaginate: isPaginate,
        ),
      );
    } on CustomException catch (e, s) {
      log("error $e $s");
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}

List<CoursefeedbackItemEntity> _parseCourseFeedbacks(
    List<Map<String, dynamic>> rawList) {
  final List<CoursefeedbackItemEntity> results = [];
  for (final Map<String, dynamic> item in rawList) {
    try {
      final CoursefeedbackItemEntity entity =
          Coursefeedbacksmodel.fromJson(item).toEntity();
      results.add(entity);
    } catch (e) {
      log(e.toString());
      throw CustomException(message: "❌ حدث خطاء غير متوقع.");
    }
  }
  return results;
}
