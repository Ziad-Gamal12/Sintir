import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetExamResultsReponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/QuestionMistakeModel.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestAnswerKeyStore.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/EdgeFunctionsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/utils/SupabaseBuckets.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/my_results_repo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/TestResulteModel.dart';
import 'package:sintir/locale_keys.dart';

class TestItemRepoImpli implements Testitemrepo {
  final StorageService storageService;
  final DataBaseService databaseservice;
  final MyResultsRepo myResultsRepo;
  final EdgeFunctionsService edgeFunctions;
  final TestAnswerKeyStore answerKeys;
  DocumentSnapshot? lastTestResultDoc;

  TestItemRepoImpli({
    required this.storageService,
    required this.databaseservice,
    required this.myResultsRepo,
    EdgeFunctionsService? edgeFunctions,
    TestAnswerKeyStore? answerKeys,
  })  : edgeFunctions = edgeFunctions ?? EdgeFunctionsService(),
        answerKeys = answerKeys ?? TestAnswerKeyStore();

  @override
  Future<Either<Failure, void>> uploadTestQuestionsImages({
    required List<CourseTestQuestionEntity> questions,
  }) async {
    try {
      for (CourseTestQuestionEntity question in questions) {
        final file = question.imageFile;
        if (file != null) {
          final url = await storageService.uploadFile(
            file: file,
            bucketname: SupabaseBuckets.Courses.name,
          );
          question.imageUrl = url;
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
  Future<Either<Failure, void>> uploadTestQuestionsSolutionsImages({
    required List<CourseTestQuestionEntity> questions,
  }) async {
    try {
      for (CourseTestQuestionEntity question in questions) {
        final file = question.solutionFile;
        if (file != null) {
          final url = await storageService.uploadFile(
            file: file,
            bucketname: SupabaseBuckets.Courses.name,
          );
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
  Future<Either<Failure, TestResultEntity>> submitTestAttempt({
    required String courseId,
    required String sectionId,
    required CourseTestEntity test,
  }) async {
    try {
      final response = await edgeFunctions.invoke('submit-test-attempt', {
        'courseId': courseId,
        'sectionId': sectionId,
        'testId': test.id,
        'answers': {
          for (final question in test.questions)
            if ((question.selectedSolution ?? '').isNotEmpty)
              question.questionId: question.selectedSolution,
        },
      });
      final result = response['result'];
      if (result is! Map) {
        return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
      }
      final testResult = resultFromServer(Map<String, dynamic>.from(result));
      myResultsRepo.invalidateOverviewCache(
        userId: testResult.joinedbyentity.uid,
      );
      return right(testResult);
    } on EdgeFunctionException catch (e) {
      return left(ServerFailure(message: _submitFailureMessage(e)));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  static TestResultEntity resultFromServer(Map<String, dynamic> json) {
    final data = Map<String, dynamic>.from(json);
    data['joinedDate'] = _timestamp(data['joinedDate']);
    final joinedBy = data['joinedby'];
    if (joinedBy is Map) {
      data['joinedby'] = {
        ...Map<String, dynamic>.from(joinedBy),
        'joinedDate': _timestamp(joinedBy['joinedDate']),
      };
    }
    data['questionsSolvedList'] = data['questionsSolvedList'] ?? [];
    return Testresultemodel.fromJson(data).toEntity();
  }

  static Timestamp _timestamp(Object? value) {
    final parsed = value is String ? DateTime.tryParse(value) : null;
    return Timestamp.fromDate(parsed?.toLocal() ?? DateTime.now());
  }

  static String _submitFailureMessage(EdgeFunctionException e) {
    switch (e.code) {
      case 'max_attempts_reached':
        return LocaleKeys.maxAttemptsReached;
      case 'network_error':
      case 'network_timeout':
        return LocaleKeys.noInternet;
      case 'not_subscribed':
      case 'course_unavailable':
      case 'inactive_user':
      case 'not_student':
        return LocaleKeys.secureContentAccessDenied;
      case 'test_not_found':
      case 'test_not_ready':
        return LocaleKeys.dataNotFound;
      case 'busy':
        return LocaleKeys.testAttemptRetry;
      default:
        return LocaleKeys.errorOccurredMessage;
    }
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
        if (!isPaginate) lastTestResultDoc = null;
        return right(
          GetExamResultsReponseEntity(
            results: [],
            hasMore: false,
            isPaginate: isPaginate,
          ),
        );
      }

      if (response.lastDocumentSnapshot != null) {
        lastTestResultDoc = response.lastDocumentSnapshot;
      }

      final bool hasMore = response.hasMore ?? false;
      final listData = response.listData! as List<Map<String, dynamic>>;

      final results = (listData.length > 100)
          ? await compute(_parseTestResults, listData)
          : _parseTestResults(listData);

      return right(
        GetExamResultsReponseEntity(
          results: results,
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

  @override
  Future<Either<Failure, TestResultEntity>> getHighestScore({
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    try {
      final query = {"orderBy": "result", "limit": 1};

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

      final result = Testresultemodel.fromJson(
        response.listData![0],
      ).toEntity();
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
      final query = {"orderBy": "result", "descending": false, "limit": 1};

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

      final result = Testresultemodel.fromJson(
        response.listData![0],
      ).toEntity();
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
          {"field": "isPassed", "operator": "==", "value": false},
        ],
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
          {"field": "isPassed", "operator": "==", "value": true},
        ],
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
          {"field": "joinedby.uid", "operator": "==", "value": userId},
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
  Future<Either<Failure, void>> storeMyMistakes({
    required TestResultEntity testResult,
    required String userUID,
  }) async {
    try {
      final mistakes = _getMyMistakes(
        questions: testResult.questionsSolvedListEntity,
        courseId: testResult.courseId,
        courseSubject: testResult.courseSubject,
        sectionId: testResult.sectionId,
      );

      await Future.wait(
        mistakes.map((mistake) async {
          final String questionId = mistake.progress.questionId;

          if (questionId.isEmpty) return;
          final docPath = FireStoreRequirmentsEntity(
            collection: BackendEndpoints.usersCollectionName,
            docId: userUID,
            subCollection: BackendEndpoints.myMistakesSubCollection,
            subDocId: questionId,
          );
          final existingData = await databaseservice.getData(
            requirements: docPath,
          );

          if (existingData.docData != null) {
            final currentMistake = QuestionMistakeModel.fromJson(
              existingData.docData!,
            ).toEntity();
            final updatedMistake = mistake.copyWith(
              progress: mistake.progress.copyWith(
                wrongCount: currentMistake.progress.wrongCount + 1,
                correctStreak: 0,
                lastAnsweredAt: DateTime.now(),
                status: MistakeStatus.active,
              ),
            );
            await databaseservice.setData(
              requirements: docPath,
              data: QuestionMistakeModel.fromEntity(updatedMistake).toJson(),
            );
          } else {
            await databaseservice.setData(
              requirements: docPath,
              data: QuestionMistakeModel.fromEntity(mistake).toJson(),
            );
          }
        }),
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  List<QuestionMistakeEntity> _getMyMistakes({
    required List<ExamResultSolvedQuestionEntity> questions,
    required String courseId,
    required String sectionId,
    required String courseSubject,
  }) {
    return questions
        .where((q) => q.isCorrect == false)
        .map(
          (q) => QuestionMistakeEntity(
            courseId: courseId,
            sectionId: sectionId,
            courseSubject: courseSubject,
            question: q,
            progress: MistakeProgressEntity(
              questionId: q.question.questionId,
              lastAnsweredAt: DateTime.now(),
              correctStreak: 0,
              wrongCount: 1,
              status: MistakeStatus.active,
            ),
          ),
        )
        .toList();
  }

  @override
  Future<Either<Failure, void>> updateTest({
    required CourseTestEntity test,
    required String courseId,
    required String sectionId,
  }) async {
    try {
      await answerKeys.saveTest(
        courseId: courseId,
        sectionId: sectionId,
        test: test,
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfTheResultHidden({
    required String courseId,
    required String sectionId,
    required String testId,
  }) async {
    try {
      final response = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
          sub2DocId: testId,
        ),
      );
      if (response.docData == null) {
        return right(false);
      }
      if (response.docData?["type"] == "Test") {
        CourseTestEntity test = Coursetestmodel.fromJson(
          response.docData!,
        ).toEntity();
        return right(!test.showResult);
      }
      return right(false);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, bool>> hasReachedMaxAttempts({
    required String courseId,
    required String sectionId,
    required CourseTestEntity test,
    required String userId,
  }) async {
    try {
      if (test.numberOfAttempts == null) return right(false);

      final query = {
        "filters": [
          {"field": "joinedby.uid", "operator": "==", "value": userId},
        ],
        "orderBy": "joinedDate",
        "descending": true,
      };
      final count = await databaseservice.getCollectionItemsCount(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
          sub2DocId: test.id,
          subCollection3: BackendEndpoints.testResultsSubCollection,
        ),
        query: query,
      );

      return right(count >= test.numberOfAttempts!);
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
