import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/TestResulteModel.dart';
import 'package:sintir/Features/MyResults/Domain/Entities/GetMyResultsResponseEntity.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/MyResultsRepo.dart';

class MyResultsRepoImpl implements MyResultsRepo {
  final Databaseservice dataBaseService;

  MyResultsRepoImpl({required this.dataBaseService});
  Map<String, dynamic> getMyResultsQuery = {
    "limit": 10,
    "startAfter": null,
  };
  DocumentSnapshot? getMyResultsLastDoc;
  @override
  Future<Either<Failure, GetMyResultsResponseEntity>> getMyResults(
      {required String userId, required bool isPaginate}) async {
    try {
      if (isPaginate) {
        getMyResultsQuery["startAfter"] = getMyResultsLastDoc;
      } else {
        getMyResultsQuery["startAfter"] = null;
      }
      final result = await dataBaseService.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userId,
          subCollection: BackendEndpoints.myResultsSubCollection,
        ),
        query: getMyResultsQuery,
      );
      if (result.listData == null) {
        return Left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (result.listData!.isEmpty) {
        return Right(GetMyResultsResponseEntity(
            hasMore: false, results: [], isPaginate: isPaginate));
      }
      if (result.lastDocumentSnapshot != null) {
        getMyResultsLastDoc = result.lastDocumentSnapshot;
      }
      List<TestResultEntity> results = await compute(
          _parseMyResults, result.listData! as List<Map<String, dynamic>>);
      return Right(GetMyResultsResponseEntity(
          hasMore: result.hasMore ?? false,
          results: results,
          isPaginate: isPaginate));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}

List<TestResultEntity> _parseMyResults(List<Map<String, dynamic>> data) {
  return data.map((e) => Testresultemodel.fromJson(e).toEntity()).toList();
}
