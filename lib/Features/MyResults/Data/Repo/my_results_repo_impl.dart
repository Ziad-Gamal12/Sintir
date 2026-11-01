import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/TestResulteModel.dart';
import 'package:sintir/Features/MyResults/Domain/Entities/get_my_results_response_entity.dart';
import 'package:sintir/Features/MyResults/Data/Repo/my_results_overview_calculator.dart';
import 'package:sintir/Features/MyResults/Domain/Repo/my_results_repo.dart';
import 'package:sintir/locale_keys.dart';

class MyResultsRepoImpl implements MyResultsRepo {
  final DataBaseService dataBaseService;

  MyResultsRepoImpl({required this.dataBaseService});
  static const int _pageSize = 10;
  final Map<String, dynamic> getMyResultsQuery = {"limit": _pageSize};
  DocumentSnapshot? getMyResultsLastDoc;
  MyResultsOverview? _cachedOverview;
  String? _activeUserId;
  int _loadedCount = 0;

  @override
  void invalidateOverviewCache({required String userId}) {
    if (_activeUserId == userId) _cachedOverview = null;
  }

  @override
  Future<Either<Failure, GetMyResultsResponseEntity>> getMyResults(
      {required String userId, required bool isPaginate}) async {
    try {
      if (!isPaginate || _activeUserId != userId) {
        _activeUserId = userId;
        invalidateOverviewCache(userId: userId);
        getMyResultsLastDoc = null;
        _loadedCount = 0;
        getMyResultsQuery["startAfter"] = null;
      } else {
        getMyResultsQuery["startAfter"] = getMyResultsLastDoc;
      }
      final requirements = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userId,
        subCollection: BackendEndpoints.myResultsSubCollection,
      );
      final result = await dataBaseService.getData(
          requirements: requirements, query: getMyResultsQuery);
      if (result.listData == null) {
        return Left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      if (result.lastDocumentSnapshot != null) {
        getMyResultsLastDoc = result.lastDocumentSnapshot;
      }
      final pageData = result.listData!.cast<Map<String, dynamic>>();
      final results = await compute(_parseMyResults, pageData);
      _loadedCount += results.length;
      _cachedOverview ??= await _loadOverview(requirements);
      return Right(GetMyResultsResponseEntity(
          hasMore: _loadedCount < _cachedOverview!.totalCount,
          results: results,
          isPaginate: isPaginate,
          totalCount: _cachedOverview!.totalCount,
          overallAveragePercent: _cachedOverview!.averagePercent));
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  Future<MyResultsOverview> _loadOverview(
      FireStoreRequirmentsEntity requirements) async {
    final count = await dataBaseService.getCollectionItemsCount(
        requirements: requirements);
    final response = await dataBaseService
        .getData(requirements: requirements, query: const <String, dynamic>{});
    if (response.listData == null) {
      throw StateError(LocaleKeys.dataNotFound);
    }
    return MyResultsOverviewCalculator.fromDocuments(
        response.listData!.cast<Map<String, dynamic>>(),
        totalCount: count);
  }
}

List<TestResultEntity> _parseMyResults(List<Map<String, dynamic>> data) {
  return data.map((e) => Testresultemodel.fromJson(e).toEntity()).toList();
}
