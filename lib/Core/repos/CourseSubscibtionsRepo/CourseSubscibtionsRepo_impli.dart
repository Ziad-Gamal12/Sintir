// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart'; // for compute
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/models/subscripersIDSModel.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/locale_keys.dart';

class CourseSubscriptionsRepoImpl implements CourseSubscibtionsRepo {
  final DataBaseService databaseService;

  CourseSubscriptionsRepoImpl({required this.databaseService});

  /// Subscribe a user to a course:
  /// 1. Add course to user's course list.
  /// 2. Add user as a subscriber.
  /// 3. Update course subscriber count.
  /// 4. Update teacher wallet (balance, transactionId, lastUpdated).
  @override
  Future<Either<Failure, void>> subscribeToCourse(
      {required CourseEntity course,
      required UserEntity userEntity,
      required String transactionId,
      required double amount}) async {
    try {
      final subscriber = _buildSubscriberEntity(userEntity);

      await Future.wait([
        _addCourseToUserList(course, userEntity),
        _addSubscriber(
            subscriber, _buildSubscriberReq(course.id, userEntity.uid)),
        _updateCourseSubscriberCount(courseId: course.id),
        _updateTeacherWalletBatch(
          teacherId: course.contentcreaterentity?.id ?? "",
          amount: amount,
          transactionId: transactionId,
        ),
      ]);

      return right(null);
    } on CustomException catch (e) {
      await _rollbackUserCourse(course, userEntity);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      await _rollbackUserCourse(course, userEntity);
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  /// Increment or decrement subscribers count
  Future<void> _updateCourseSubscriberCount({
    required String courseId,
    int delta = 1,
  }) async {
    await databaseService.updateData(
      collectionKey: BackendEndpoints.coursesCollection,
      field: "studentsCount",
      doc: courseId,
      data: FieldValue.increment(delta),
    );
  }

  /// Add new subscriber to course
  Future<void> _addSubscriber(
    SubscriberEntity subscriber,
    FireStoreRequirmentsEntity requirements,
  ) async {
    final data =
        Subscripersidsmodel.fromEntit(subscriberentity: subscriber).toJson();
    await databaseService.setData(data: data, requirements: requirements);
  }

  SubscriberEntity _buildSubscriberEntity(UserEntity user) {
    return SubscriberEntity(
      id: user.uid,
      name: user.firstName,
      gender: user.gender,
      phone: user.phoneNumber,
      educationLevel: user.studentExtraDataEntity?.educationLevel ?? "",
      imageUrl: user.profilePicurl,
      address: user.address,
    );
  }

  /// Update teacher wallet (balance, transaction id, last updated)
  Future<void> _updateTeacherWalletBatch({
    required String teacherId,
    required double amount,
    required String transactionId,
  }) async {
    if (teacherId.isEmpty) return;

    final double netAmount = amount - (amount * 0.05);
    final updates = {
      "teacherExtraData.wallet.balance": FieldValue.increment(netAmount),
      "teacherExtraData.wallet.last_transaction_id": transactionId,
      "teacherExtraData.wallet.updated_at": DateTime.now().toIso8601String(),
      "teacherExtraData.wallet.total_earned": FieldValue.increment(netAmount),
    };

    for (final entry in updates.entries) {
      await databaseService.updateData(
        collectionKey: BackendEndpoints.usersCollectionName,
        field: entry.key,
        doc: teacherId,
        data: entry.value,
      );
    }
  }

  FireStoreRequirmentsEntity _buildSubscriberReq(
      String courseId, String userId) {
    return FireStoreRequirmentsEntity(
      collection: BackendEndpoints.coursesCollection,
      docId: courseId,
      subDocId: userId,
      subCollection: BackendEndpoints.subscribersSubCollection,
    );
  }

  Future<void> _addCourseToUserList(
    CourseEntity course,
    UserEntity user,
  ) async {
    final data = Coursemodel.fromEntity(courseEntity: course).toJson();
    await databaseService.setData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: user.uid,
        subDocId: course.id,
        subCollection: BackendEndpoints.subscribetoCourseCollection,
      ),
      data: data,
    );
  }

  Future<bool> _isCourseInUserList(CourseEntity course, UserEntity user) async {
    return await databaseService.isDataExists(
      key: BackendEndpoints.usersCollectionName,
      docId: user.uid,
      subDocId: course.id,
      subCollectionKey: BackendEndpoints.subscribetoCourseCollection,
    );
  }

  Future<void> _rollbackUserCourse(CourseEntity course, UserEntity user) async {
    if (await _isCourseInUserList(course, user)) {
      await databaseService.deleteDoc(
        collectionKey: BackendEndpoints.usersCollectionName,
        docId: user.uid,
        subDocId: course.id,
        subCollectionKey: BackendEndpoints.subscribetoCourseCollection,
      );
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfSubscribed({
    required String userID,
    required String courseID,
  }) async {
    try {
      final isSubscribed = await databaseService.isDataExists(
        key: BackendEndpoints.usersCollectionName,
        subCollectionKey: BackendEndpoints.checkifSubscribedSubCollection,
        docId: userID,
        subDocId: courseID,
      );
      return right(isSubscribed);
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  /// ============= Subscribers Pagination =============

  DocumentSnapshot? _lastSubscribersDoc;
  final Map<String, dynamic> _baseQuery = {"startAfter": null, "limit": 10};

  @override
  Future<Either<Failure, GetCourseSubscribersEntity>> getSubscribers({
    required String courseID,
    required bool isPaginate,
  }) async {
    try {
      final query = Map<String, dynamic>.from(_baseQuery)
        ..["startAfter"] = isPaginate ? _lastSubscribersDoc : null;

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

      _lastSubscribersDoc = response.lastDocumentSnapshot;

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
      Map<String, dynamic> query = {
        "startAfter": isPaginate ? _lastSubscribersDoc : null,
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

      _lastSubscribersDoc = response.lastDocumentSnapshot;

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
}

List<SubscriberEntity> _parseSubscribers(List<dynamic> rawList) {
  return rawList
      .map((e) => Subscripersidsmodel.fromJson(e).toEntity())
      .toList();
}
