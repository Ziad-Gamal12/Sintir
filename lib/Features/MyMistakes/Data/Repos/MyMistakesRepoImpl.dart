import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/MistakeProgressEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/QuestionMistakeModel.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/TestResulteModel.dart';
import 'package:sintir/Features/MyMistakes/Domain/Entities/GetMyMistakesResponseEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';
import 'package:sintir/locale_keys.dart';

class MyMistakesRepoImpl implements MyMistakesRepo {
  final DataBaseService databaseservice;
  MyMistakesRepoImpl({required this.databaseservice});

  // Track pagination state locally but keep query config inside the method
  DocumentSnapshot? _lastDoc;

  @override
  Future<Either<Failure, GetMyMistakesResponseEntity>> getMyMistakes({
    required String userUID,
    required bool isPaginate,
  }) async {
    try {
      final query = {
        "limit": 10,
        "startAfter": isPaginate ? _lastDoc : null,
      };
      final result = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userUID,
          subCollection: BackendEndpoints.myMistakesSubCollection,
        ),
        query: query,
      );

      final listData = result.listData as List<Map<String, dynamic>>? ?? [];

      if (listData.isEmpty) {
        return Right(GetMyMistakesResponseEntity(
          hasMore: false,
          myMistakesList: [],
          isPaginate: isPaginate,
        ));
      }

      _lastDoc = result.lastDocumentSnapshot;

      final mistakes = listData
          .map((e) => QuestionMistakeModel.fromJson(e).toEntity())
          .toList();

      return Right(GetMyMistakesResponseEntity(
        hasMore: result.hasMore ?? false,
        myMistakesList: mistakes,
        isPaginate: isPaginate,
      ));
    } on CustomException catch (e) {
      log(e.message);
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  Future<void> _processMistakeUpdates({
    required TestResultEntity testResult,
    required String userUID,
  }) async {
    await Future.wait(testResult.questionsSolvedListEntity.map((solved) async {
      final requirements = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userUID,
        subCollection: BackendEndpoints.myMistakesSubCollection,
        subDocId: solved.question.questionId,
      );

      final response =
          await databaseservice.getData(requirements: requirements);
      if (response.docData == null) return;

      final existing =
          QuestionMistakeModel.fromJson(response.docData!).toEntity();
      int newStreak =
          solved.isCorrect ? (existing.progress.correctStreak + 1) : 0;
      int newWrongCount = solved.isCorrect
          ? existing.progress.wrongCount
          : (existing.progress.wrongCount + 1);
      MistakeStatus newStatus = MistakeStatus.active;
      if (newStreak >= 3) {
        newStatus = MistakeStatus.mastered;
      } else if (newStreak >= 2) {
        newStatus = MistakeStatus.improving;
      }

      final updated = existing.copyWith(
        progress: existing.progress.copyWith(
          correctStreak: newStreak,
          wrongCount: newWrongCount,
          lastAnsweredAt: DateTime.now(),
          status: newStatus,
        ),
      );

      await databaseservice.setData(
        requirements: requirements,
        data: QuestionMistakeModel.fromEntity(updated).toJson(),
      );
    }));
  }

  @override
  Future<Either<Failure, void>> storeTestMyMistakesExamResult({
    required TestResultEntity testResult,
    required String userUID,
  }) async {
    try {
      final resultJson = Testresultemodel.fromEntity(testResult).toJson();
      await Future.wait([
        addTestResultToUsersResults(userUID, testResult, resultJson),
        _processMistakeUpdates(testResult: testResult, userUID: userUID),
      ]);
      return const Right(null);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  Future<void> addTestResultToUsersResults(
    String userUID,
    TestResultEntity testResult,
    Map<String, dynamic> json,
  ) {
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

  @override
  Future<Either<Failure, List<QuestionMistakeEntity>>> getAllActiveMistakes(
      {required String userUID}) async {
    try {
      final result = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userUID,
          subCollection: BackendEndpoints.myMistakesSubCollection,
        ),
      );

      final listData = result.listData as List<Map<String, dynamic>>? ?? [];

      if (listData.isEmpty) {
        return const Right([]);
      }
      final mistakes = listData
          .map((e) => QuestionMistakeModel.fromJson(e).toEntity())
          .toList();

      return Right(mistakes);
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: LocaleKeys.generalError));
    }
  }
}
