import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/entities/GetCourseReportsResponseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursereportsitemModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

class CourseReportsRepoimpli implements CourseReportsRepo {
  final Databaseservice databaseservice;
  CourseReportsRepoimpli({required this.databaseservice});

  @override
  Future<Either<Failure, void>> addCourseReport({
    required String courseId,
    required CourseReportEntity reportEntity,
  }) async {
    try {
      final json = CoursereportsitemModel.fromEntity(
        courseReportsItemEntity: reportEntity,
      ).toJson();
      await databaseservice.setData(
        data: json,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.reportsSubCollection,
        ),
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  DocumentSnapshot? _lastDoc;

  final Map<String, dynamic> _baseQuery = {
    "startAfter": null,
    "orderBy": "date",
    "limit": 10,
  };

  @override
  Future<Either<Failure, GetCourseReportsResponseEntity>> getCourseReports({
    required String courseId,
    required bool isPaginate,
  }) async {
    try {
      _baseQuery["startAfter"] = isPaginate ? _lastDoc : null;
      final response = await databaseservice.getData(
        query: _baseQuery,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.reportsSubCollection,
        ),
      );
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right(
          GetCourseReportsResponseEntity(
            reports: [],
            hasMore: false,
            isPaginate: isPaginate,
          ),
        );
      }
      if (response.lastDocumentSnapshot != null) {
        _lastDoc = response.lastDocumentSnapshot;
      }
      final reports = await compute(
          _mapReports, response.listData as List<Map<String, dynamic>>);
      final hasMore = response.hasMore ?? false;
      return right(
        GetCourseReportsResponseEntity(
          reports: reports,
          hasMore: hasMore,
          isPaginate: isPaginate,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}

List<CourseReportEntity> _mapReports(List<Map<String, dynamic>> data) {
  return data
      .map((e) => CoursereportsitemModel.fromJson(e).toEntity())
      .toList();
}
