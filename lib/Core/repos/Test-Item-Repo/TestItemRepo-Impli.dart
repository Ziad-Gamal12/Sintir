import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/entities/GetExamResultsReponseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/TestResulteModel.dart';

class TestItemRepoImpli implements Testitemrepo {
  final StorageService storageService;
  final Databaseservice databaseservice;

  TestItemRepoImpli(
      {required this.storageService, required this.databaseservice});
  @override
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<CourseTestQuestionEntity> questions}) async {
    try {
      for (var question in questions) {
        if (question.imageFile != null) {
          String url =
              await storageService.uploadFile(file: question.imageFile!);
          question.imageUrl = url;
        }
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> addTestResult(
      {required TestResultEntity testResult,
      required String courseId,
      required String sectionId,
      required String sectionItemId}) async {
    try {
      Map<String, dynamic> json =
          Testresultemodel.fromEntity(testResult).toJson();
      await databaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.coursesCollection,
              docId: courseId,
              subCollection: BackendEndpoints.sectionsSubCollection,
              subDocId: sectionId,
              subCollection2: BackendEndpoints.sectionItemsSubCollection,
              sub2DocId: sectionItemId,
              subCollection3: BackendEndpoints.testResultsSubCollection,
              sub3DocId: testResult.serialNumber),
          data: json);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Map<String, dynamic> getTestResultQuery = {
    "orderBy": "joinedDate",
    "limit": 10,
    "startAfter": null,
  };
  DocumentSnapshot? lastTestResultDoc;
  @override
  Future<Either<Failure, GetExamResultsReponseEntity>> getTestResults(
      {required String courseId,
      required String sectionId,
      required String examId,
      required bool isPaginate}) async {
    try {
      getTestResultQuery["startAfter"] = isPaginate ? lastTestResultDoc : null;
      final response = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: examId,
            subCollection3: BackendEndpoints.testResultsSubCollection,
          ),
          query: getTestResultQuery);
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right(GetExamResultsReponseEntity(
            results: [], hasMore: false, isPaginate: isPaginate));
      }
      if (response.lastDocumentSnapshot != null) {
        lastTestResultDoc = response.lastDocumentSnapshot;
      }
      bool hasMore = response.hasMore ?? false;
      List<TestResultEntity> results = await compute(
          _parseTestResults, response.listData! as List<Map<String, dynamic>>);
      return right(GetExamResultsReponseEntity(
          results: results, hasMore: hasMore, isPaginate: isPaginate));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Map<String, dynamic> getHighestScoreQuery = {
    "orderBy": "result",
    "limit": 1,
  };
  @override
  Future<Either<Failure, TestResultEntity>> getHighestScore(
      {required String courseId,
      required String sectionId,
      required String sectionItemId}) async {
    try {
      final response = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: sectionItemId,
            subCollection3: BackendEndpoints.testResultsSubCollection,
          ),
          query: getHighestScoreQuery);
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right(TestResultEntity.empty());
      }
      TestResultEntity result =
          Testresultemodel.fromJson(response.listData![0]).toEntity();
      return right(result);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Map<String, dynamic> getLowestScoreQuery = {
    "orderBy": "result",
    "descending": false,
    "limit": 1,
  };
  @override
  Future<Either<Failure, TestResultEntity>> getLowestScore(
      {required String courseId,
      required String sectionId,
      required String sectionItemId}) async {
    try {
      final response = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: sectionItemId,
            subCollection3: BackendEndpoints.testResultsSubCollection,
          ),
          query: getLowestScoreQuery);
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right(TestResultEntity.empty());
      }
      TestResultEntity result =
          Testresultemodel.fromJson(response.listData![0]).toEntity();
      return right(result);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, int>> getAttendedCount(
      {required String courseId,
      required String sectionId,
      required String testId}) async {
    try {
      final response = await databaseservice.getCollectionItemsCount(
          requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollection: BackendEndpoints.sectionsSubCollection,
        subDocId: sectionId,
        subCollection2: BackendEndpoints.sectionItemsSubCollection,
        sub2DocId: testId,
        subCollection3: BackendEndpoints.joinedBySubCollection,
      ));
      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }

  Map<String, dynamic> getFailedStudentsQuery = {
    "filters": [
      {"field": "isPassed", "operator": "==", "value": false}
    ]
  };
  @override
  Future<Either<Failure, int>> getFailedStudentsCount(
      {required String courseId,
      required String sectionId,
      required String testId}) async {
    try {
      final response = await databaseservice.getCollectionItemsCount(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: testId,
            subCollection3: BackendEndpoints.testResultsSubCollection,
          ),
          query: getFailedStudentsQuery);
      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }

  Map<String, dynamic> getSuccessedStudentsQuery = {
    "filters": [
      {"field": "isPassed", "operator": "==", "value": true}
    ]
  };
  @override
  Future<Either<Failure, int>> getSuccessedStudentsCount(
      {required String courseId,
      required String sectionId,
      required String testId}) async {
    try {
      final response = await databaseservice.getCollectionItemsCount(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: testId,
            subCollection3: BackendEndpoints.testResultsSubCollection,
          ),
          query: getSuccessedStudentsQuery);
      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }

  Map<String, dynamic> getUserResultsOfExamQuery = {
    "filters": [
      {"field": "joinedby.uid", "operator": "==", "value": null}
    ],
    "orderBy": "joinedDate",
    "descending": true,
  };
  @override
  Future<Either<Failure, List<TestResultEntity>>> getUserResultsOfExam(
      {required String courseId,
      required String sectionId,
      required String examId,
      required String userId}) async {
    try {
      getUserResultsOfExamQuery["filters"][0]["value"] = userId;
      final response = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: examId,
            subCollection3: BackendEndpoints.testResultsSubCollection,
          ),
          query: getUserResultsOfExamQuery);
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right([]);
      }
      return right(
          _parseTestResults(response.listData! as List<Map<String, dynamic>>));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log("error in user results of exam $e", stackTrace: s);
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }
}

List<TestResultEntity> _parseTestResults(List<Map<String, dynamic>> data) {
  return data.map((e) => Testresultemodel.fromJson(e).toEntity()).toList();
}
