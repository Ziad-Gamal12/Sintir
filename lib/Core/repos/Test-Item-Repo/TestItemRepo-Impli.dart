// Refactored TestItemRepoImpli.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetExamResultsReponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/ExamResultSolvedQuestionModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/TestResulteModel.dart';
import 'package:sintir/locale_keys.dart';

class TestItemRepoImpli implements Testitemrepo {
  final StorageService storageService;
  final DataBaseService databaseservice;

  DocumentSnapshot? lastTestResultDoc;

  TestItemRepoImpli({
    required this.storageService,
    required this.databaseservice,
  });

  @override
  Future<Either<Failure, void>> uploadTestQuestionsImages({
    required List<CourseTestQuestionEntity> questions,
  }) async {
    try {
      for (CourseTestQuestionEntity question in questions) {
        final file = question.imageFile;
        if (file != null) {
          final url = await storageService.uploadFile(file: file);
          question.imageUrl = url;
        }
      }
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> uploadTestQuestionsSolutionsImages({
    required List<CourseTestQuestionEntity> questions,
  }) async {
    try {
      for (CourseTestQuestionEntity question in questions) {
        final file = question.solutionFile;
        if (file != null) {
          final url = await storageService.uploadFile(file: file);
          question.solutionImageUrl = url;
        }
      }
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> addTestResult({
    required TestResultEntity testResult,
    required String courseId,
    required String sectionId,
    required String userUID,
    required String sectionItemId,
  }) async {
    try {
      final json = Testresultemodel.fromEntity(testResult).toJson();

      await Future.wait([
        addTestResultToExamResultsCollection(
            courseId, sectionId, sectionItemId, testResult, json),
        addTestResultToUsersResults(userUID, testResult, json),
        storeMyMistakes(testResult: testResult, userUID: userUID),
      ]);

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  Future<void> addTestResultToUsersResults(
      String userUID, TestResultEntity testResult, Map<String, dynamic> json) {
    return databaseservice.setData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userUID,
        subCollection: BackendEndpoints.myResultsSubCollection,
        subDocId: testResult.serialNumber,
      ),
      data: json,
    );
  }

  Future<void> addTestResultToExamResultsCollection(
      String courseId,
      String sectionId,
      String sectionItemId,
      TestResultEntity testResult,
      Map<String, dynamic> json) {
    return databaseservice.setData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollection: BackendEndpoints.sectionsSubCollection,
        subDocId: sectionId,
        subCollection2: BackendEndpoints.sectionItemsSubCollection,
        sub2DocId: sectionItemId,
        subCollection3: BackendEndpoints.testResultsSubCollection,
        sub3DocId: testResult.serialNumber,
      ),
      data: json,
    );
  }

  @override
  Future<Either<Failure, GetExamResultsReponseEntity>> getTestResults({
    required String courseId,
    required String sectionId,
    required String examId,
    required bool isPaginate,
  }) async {
    try {
      final Map<String, dynamic> query = {
        "orderBy": "joinedDate",
        "limit": 10,
        "startAfter": isPaginate ? lastTestResultDoc : null,
      };

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
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }

      if (response.listData!.isEmpty) {
        // When not paginating, ensure lastTestResultDoc cleared so subsequent paginations start fresh
        if (!isPaginate) lastTestResultDoc = null;
        return right(
          GetExamResultsReponseEntity(
              results: [], hasMore: false, isPaginate: isPaginate),
        );
      }

      if (response.lastDocumentSnapshot != null) {
        lastTestResultDoc = response.lastDocumentSnapshot;
      }

      final bool hasMore = response.hasMore ?? false;
      final listData = response.listData! as List<Map<String, dynamic>>;

      // only use compute for large lists (cheap heuristic)
      final results = (listData.length > 100)
          ? await compute(_parseTestResults, listData)
          : _parseTestResults(listData);

      return right(GetExamResultsReponseEntity(
          results: results, hasMore: hasMore, isPaginate: isPaginate));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, TestResultEntity>> getHighestScore({
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    try {
      final query = {
        "orderBy": "result",
        "limit": 1,
      };

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
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
      }
      if (response.listData!.isEmpty) {
        return right(TestResultEntity.empty());
      }

      final result =
          Testresultemodel.fromJson(response.listData![0]).toEntity();
      return right(result);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, TestResultEntity>> getLowestScore({
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    try {
      final query = {
        "orderBy": "result",
        "descending": false,
        "limit": 1,
      };

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
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
      }
      if (response.listData!.isEmpty) {
        return right(TestResultEntity.empty());
      }

      final result =
          Testresultemodel.fromJson(response.listData![0]).toEntity();
      return right(result);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, int>> getAttendedCount({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
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
        ),
      );
      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, int>> getFailedStudentsCount({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    try {
      final query = {
        "filters": [
          {"field": "isPassed", "operator": "==", "value": false}
        ]
      };

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
        query: query,
      );

      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, int>> getSuccessedStudentsCount({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    try {
      final query = {
        "filters": [
          {"field": "isPassed", "operator": "==", "value": true}
        ]
      };

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
        query: query,
      );

      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, List<TestResultEntity>>> getUserResultsOfExam({
    required String courseId,
    required String sectionId,
    required String examId,
    required String userId,
  }) async {
    try {
      final query = {
        "filters": [
          {"field": "joinedby.uid", "operator": "==", "value": userId}
        ],
        "orderBy": "joinedDate",
        "descending": true,
      };

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
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
      }
      if (response.listData!.isEmpty) return right([]);

      final listData = response.listData! as List<Map<String, dynamic>>;
      return right(_parseTestResults(listData));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> storeMyMistakes(
      {required TestResultEntity testResult, required String userUID}) async {
    try {
      for (ExamResultSolvedQuestionEntity question
          in _getMyMistakes(questions: testResult.questionsSolvedListEntity)) {
        await databaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.usersCollectionName,
            docId: userUID,
            subCollection: BackendEndpoints.myMistakesSubCollection,
            subDocId: question.hashCode.toString(),
          ),
          data: Examresultsolvedquestionmodel.fromEntity(question).toJson(),
        );
      }

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  List<ExamResultSolvedQuestionEntity> _getMyMistakes({
    required List<ExamResultSolvedQuestionEntity> questions,
  }) {
    final List<ExamResultSolvedQuestionEntity> myMistakes = [];

    for (final question in questions) {
      if (!question.isCorrect) {
        myMistakes.add(question);
      }
    }

    return myMistakes;
  }

  @override
  Future<Either<Failure, void>> updateTest(
      {required CourseTestEntity test,
      required String courseId,
      required String sectionId}) async {
    try {
      await databaseservice.updateData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
          sub2DocId: test.id,
        ),
        data: Coursetestmodel.fromEntity(test).toJson(),
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

List<TestResultEntity> _parseTestResults(List<Map<String, dynamic>> data) {
  return data.map((e) => Testresultemodel.fromJson(e).toEntity()).toList();
}
