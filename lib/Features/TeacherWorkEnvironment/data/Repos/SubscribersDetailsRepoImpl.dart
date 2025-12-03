import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/TestResulteModel.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/SubscribersDetailsRepo.dart';
import 'package:sintir/locale_keys.dart';

class SubscribersDetailsRepoImpl implements SubscribersDetailsRepo {
  final DataBaseService databaseservice;

  SubscribersDetailsRepoImpl({required this.databaseservice});

  @override
  Future<Either<Failure, List<CourseEntity>>>
      getSubscibersEnrolledCoursesForTeacher(
          {required String contentCreatorId,
          required String subscriberId}) async {
    try {
      Map<String, dynamic> query = {
        "filters": <Map<String, dynamic>>[
          {
            "field": "contentcreaterentity.id",
            "operator": "==",
            "value": contentCreatorId,
          },
          {
            "field": "state",
            "operator": "==",
            "value": BackendEndpoints.coursePublishedState,
          }
        ]
      };
      FireStoreRequirmentsEntity requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        subCollection: BackendEndpoints.subscribetoCourseCollection,
        docId: subscriberId,
      );
      final response = await databaseservice.getData(
        requirements: requirmentsEntity,
        query: query,
      );
      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      final List<Map<String, dynamic>> data =
          response.listData! as List<Map<String, dynamic>>;
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  @override
  Future<Either<Failure, TestResultEntity>> getSubscriberHighestScore(
      {required String subscriberId, required String courseId}) async {
    try {
      Map<String, dynamic> query = {
        "limit": 1,
        "orderBy": "result",
        "descending": true,
        "filters": <Map<String, dynamic>>[
          {
            "field": "courseId",
            "operator": "==",
            "value": courseId,
          },
        ]
      };
      FireStoreRequirmentsEntity requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        subCollection: BackendEndpoints.myResultsSubCollection,
        docId: subscriberId,
      );

      final response = await databaseservice.getData(
        requirements: requirmentsEntity,
        query: query,
      );
      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      final List<Map<String, dynamic>> data =
          response.listData! as List<Map<String, dynamic>>;
      if (data.isEmpty || data.first.isEmpty) {
        return right(
          TestResultEntity.empty(),
        );
      }
      TestResultEntity testResult =
          Testresultemodel.fromJson(data.first).toEntity();
      return right(testResult);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);

      return left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  @override
  Future<Either<Failure, TestResultEntity>> getSubscriberLowestScore(
      {required String subscriberId, required String courseId}) async {
    try {
      Map<String, dynamic> query = {
        "limit": 1,
        "orderBy": "result",
        "descending": false,
        "filters": <Map<String, dynamic>>[
          {
            "field": "courseId",
            "operator": "==",
            "value": courseId,
          },
        ]
      };
      FireStoreRequirmentsEntity requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        subCollection: BackendEndpoints.myResultsSubCollection,
        docId: subscriberId,
      );

      final response = await databaseservice.getData(
        requirements: requirmentsEntity,
        query: query,
      );
      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      final List<Map<String, dynamic>> data =
          response.listData! as List<Map<String, dynamic>>;
      if (data.isEmpty || data.first.isEmpty) {
        return right(
          TestResultEntity.empty(),
        );
      }
      TestResultEntity testResult =
          Testresultemodel.fromJson(data.first).toEntity();
      return right(testResult);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  @override
  Future<Either<Failure, List<TestResultEntity>>> getSubscriberResults(
      {required String subscriberId, required String courseId}) async {
    try {
      Map<String, dynamic> query = {
        "filters": <Map<String, dynamic>>[
          {
            "field": "courseId",
            "operator": "==",
            "value": courseId,
          },
        ]
      };
      FireStoreRequirmentsEntity requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        subCollection: BackendEndpoints.myResultsSubCollection,
        docId: subscriberId,
      );
      final response = await databaseservice.getData(
        requirements: requirmentsEntity,
        query: query,
      );
      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      final List<Map<String, dynamic>> data =
          response.listData! as List<Map<String, dynamic>>;
      List<TestResultEntity> testResults =
          data.map((e) => Testresultemodel.fromJson(e).toEntity()).toList();
      return right(testResults);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.generalError));
    }
  }
}
