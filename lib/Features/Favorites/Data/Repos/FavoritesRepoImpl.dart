import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Favorites/Domain/Repos/FavoritesRepo.dart';
import 'package:sintir/locale_keys.dart';

class FavoritesRepoImpl implements FavoritesRepo {
  final DataBaseService dataBaseService;

  FavoritesRepoImpl({required this.dataBaseService});

  @override
  Future<Either<Failure, void>> addToFavorites(
      {required String userId, required CourseEntity course}) async {
    try {
      Map<String, dynamic> data =
          Coursemodel.fromEntity(courseEntity: course).toJson();
      await dataBaseService.setData(
        data: data,
        requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.usersCollectionName,
            subCollection: BackendEndpoints.favoritesSubCollection,
            docId: userId,
            subDocId: course.id),
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  @override
  Future<Either<Failure, void>> removeFromFavorites(
      {required String userId, required CourseEntity course}) async {
    try {
      await dataBaseService.deleteDoc(
        collectionKey: BackendEndpoints.usersCollectionName,
        docId: userId,
        subCollectionKey: BackendEndpoints.favoritesSubCollection,
        subDocId: course.id,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.generalError));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getFavorites({
    required String userId,
  }) async {
    try {
      Map<String, dynamic> query = {
        "filters": <Map<String, dynamic>>[
          {
            "field": "state",
            "operator": "==",
            "value": BackendEndpoints.coursePublishedState
          }
        ]
      };
      final response = await dataBaseService.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.usersCollectionName,
            subCollection: BackendEndpoints.favoritesSubCollection,
            docId: userId,
          ),
          query: query);
      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      if (response.listData!.isEmpty) {
        return right([]);
      }

      List<CourseEntity> favourites = await compute(
          _parseCourses, response.listData! as List<Map<String, dynamic>>);
      return right(favourites);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.generalError));
    }
  }
}

List<CourseEntity> _parseCourses(List<Map<String, dynamic>> listData) {
  return listData.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
}
