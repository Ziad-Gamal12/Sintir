import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/ExamResultSolvedQuestionModel.dart';
import 'package:sintir/Features/MyMistakes/Domain/Entities/GetMyMistakesResponseEntity.dart';
import 'package:sintir/Features/MyMistakes/Domain/Repo/MyMistakesRepo.dart';

class MyMistakesRepoImpl implements MyMistakesRepo {
  final DataBaseService databaseservice;
  MyMistakesRepoImpl({required this.databaseservice});
  final Map<String, dynamic> getMyMistakesQuery = {
    "startAfter": null,
    "limit": 10
  };
  DocumentSnapshot? getMyMistakesLastDoc;
  @override
  Future<Either<Failure, GetMyMistakesResponseEntity>> getMyMistakes(
      {required String userUID, required bool isPaginate}) async {
    try {
      if (isPaginate) {
        getMyMistakesQuery["startAfter"] = getMyMistakesLastDoc;
      } else {
        getMyMistakesQuery["startAfter"] = null;
      }

      final result = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userUID,
          subCollection: BackendEndpoints.myMistakesSubCollection,
        ),
        query: getMyMistakesQuery,
      );
      if (result.listData == null) {
        return Left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (result.listData!.isEmpty) {
        return Right(GetMyMistakesResponseEntity(
            hasMore: false,
            questionsSolvedListEntity: [],
            isPaginate: isPaginate));
      }
      if (result.lastDocumentSnapshot != null) {
        getMyMistakesLastDoc = result.lastDocumentSnapshot;
      }
      List<ExamResultSolvedQuestionEntity> questionsSolvedListEntity =
          parseMyMistakes(result.listData as List<Map<String, dynamic>>);
      bool hasMore = result.hasMore ?? false;
      return Right(
        GetMyMistakesResponseEntity(
            hasMore: hasMore,
            questionsSolvedListEntity: questionsSolvedListEntity,
            isPaginate: isPaginate),
      );
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(ServerFailure(message: "حدث خطاء غير متوقع"));
    }
  }

  List<ExamResultSolvedQuestionEntity> parseMyMistakes(
      List<Map<String, dynamic>> data) {
    return data
        .map((e) => Examresultsolvedquestionmodel.fromJson(e).toEntity())
        .toList();
  }
}
