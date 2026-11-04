// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart'; // for compute
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/SubscriberModel.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRepo.dart';
import 'package:sintir/Core/repos/CourseCheckoutRepo/CourseCheckoutRequestException.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseSubscriptionsRepoImpl implements CourseSubscibtionsRepo {
  final DataBaseService databaseService;
  final CourseCheckoutGateway checkoutGateway;

  CourseSubscriptionsRepoImpl({
    required this.databaseService,
    required this.checkoutGateway,
  });

  @override
  Future<Either<Failure, void>> subscribeToCourse(
      {required CourseEntity course,
      required UserEntity userEntity,
      required String transactionId,
      required TransactionEntity transactionEntity,
      required double amount}) async {
    return left(ServerFailure(
      message: 'Enrollment is finalized only by the verified payment callback.',
    ));
  }

  @override
  Future<Either<Failure, bool>> checkIfSubscribed({
    required String courseID,
  }) async {
    try {
      final isSubscribed = await checkoutGateway.isSubscribed(courseID);
      return right(isSubscribed);
    } on CourseCheckoutRequestException catch (e) {
      log(e.toString());

      return left(ServerFailure(message: e.message));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  final Map<String, DocumentSnapshot?> _lastSubscribersDocs = {};
  final Map<String, DocumentSnapshot?> _lastSearchSubscribersDocs = {};
  final Map<String, dynamic> _baseQuery = {"startAfter": null, "limit": 10};

  String _searchCursorKey(String courseId, String searchKey) =>
      '$courseId\u0000$searchKey';

  @override
  Future<Either<Failure, GetCourseSubscribersEntity>> getSubscribers({
    required String courseID,
    required bool isPaginate,
  }) async {
    try {
      if (!isPaginate) _lastSubscribersDocs.remove(courseID);
      final query = Map<String, dynamic>.from(_baseQuery)
        ..["startAfter"] = isPaginate ? _lastSubscribersDocs[courseID] : null;

      final response = await databaseService.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          subCollection: BackendEndpoints.subscribersSubCollection,
          docId: courseID,
        ),
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }

      if (response.listData!.isEmpty) {
        return right(GetCourseSubscribersEntity(
          subscribers: [],
          hasMore: false,
          isPaginate: isPaginate,
        ));
      }

      _lastSubscribersDocs[courseID] = response.lastDocumentSnapshot;

      final subscribers = await compute(_parseSubscribers, response.listData!);
      final hasMore = response.hasMore ?? false;

      return right(GetCourseSubscribersEntity(
        subscribers: subscribers,
        hasMore: hasMore,
        isPaginate: isPaginate,
      ));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, int>> getSubscribersCount(
      {required String courseID}) async {
    try {
      final response = await databaseService.getCollectionItemsCount(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseID,
          subCollection: BackendEndpoints.subscribersSubCollection,
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
  Future<Either<Failure, GetCourseSubscribersEntity>> searchSubscribers(
      {required String courseID,
      required String searchKey,
      required bool isPaginate}) async {
    try {
      final cursorKey = _searchCursorKey(courseID, searchKey);
      if (!isPaginate) {
        final coursePrefix = '$courseID\u0000';
        _lastSearchSubscribersDocs.removeWhere(
          (key, _) => key.startsWith(coursePrefix),
        );
      }
      Map<String, dynamic> query = {
        "startAfter": isPaginate ? _lastSearchSubscribersDocs[cursorKey] : null,
        "limit": 10,
        "searchField": "name",
        "searchValue": searchKey,
      };

      final response = await databaseService.getData(
        query: query,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          subCollection: BackendEndpoints.subscribersSubCollection,
          docId: courseID,
        ),
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }

      if (response.listData!.isEmpty) {
        return right(GetCourseSubscribersEntity(
          subscribers: [],
          hasMore: false,
          isPaginate: isPaginate,
        ));
      }

      _lastSearchSubscribersDocs[cursorKey] = response.lastDocumentSnapshot;

      final subscribers = await compute(_parseSubscribers, response.listData!);
      final hasMore = response.hasMore ?? false;

      return right(GetCourseSubscribersEntity(
        subscribers: subscribers,
        hasMore: hasMore,
        isPaginate: isPaginate,
      ));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> storeSubscribtionTransaction(
      {required String courseID,
      required String userID,
      required TransactionEntity transaction}) async {
    return left(ServerFailure(
      message:
          'Payment transactions are written by the verified payment callback.',
    ));
  }
}

List<SubscriberEntity> _parseSubscribers(List<dynamic> rawList) {
  return rawList.map((e) => SubscriberModel.fromJson(e).toEntity()).toList();
}
