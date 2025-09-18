// ignore_for_file: file_names

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart'; // compute
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/entities/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/helper/GetUID.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/models/PaymentModels/PaymentDataModel.dart';
import 'package:sintir/Core/models/subscripersIDSModel.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/PayMobService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

/// Implementation of Course Subscriptions repository.
/// Note: kept original class name to avoid breaking existing references.
class CourseSubscibtionsRepoimpli implements CourseSubscibtionsRepo {
  final PayMobService payMobService;
  final Databaseservice datebaseservice;

  CourseSubscibtionsRepoimpli({
    required this.datebaseservice,
    required this.payMobService,
  });

  /// ---------- Payment helpers ----------
  Future<int?> createPaymentOrder(
      {required Orderdataentity orderEntity}) async {
    return await payMobService.createPaymentOrder(orderEntity: orderEntity);
  }

  Future<String?> getAuthToken() async {
    return await payMobService.getAuthToken();
  }

  Future<String> getPaymentToken(
      {required Paymentdataentity paymententity}) async {
    return await payMobService.getPaymentToken(paymententity: paymententity);
  }

  /// Pay with Fawry flow: get auth token -> create order -> get payment token
  @override
  Future<Either<Failure, String>> payWithFawry({
    required Paymentdataentity paymententity,
    required Orderdataentity orderEntity,
  }) async {
    try {
      final String? authToken = await getAuthToken();
      if (authToken == null) {
        return left(
            ServerFailure(message: "حدث خطأ أثناء الحصول على التوكن الخاص بك"));
      }

      orderEntity.authToken = authToken;
      paymententity.authToken = authToken;

      final int? paymentOrderId =
          await createPaymentOrder(orderEntity: orderEntity);
      if (paymentOrderId == null) {
        return left(ServerFailure(message: "حدث خطاء في انشاء الطلبية"));
      }
      paymententity.orderId = paymentOrderId;

      try {
        log(Paymentdatamodel.formEntity(paymententity).toJson().toString());
      } catch (_) {}

      final String token = await getPaymentToken(paymententity: paymententity);
      return right(token);
    } catch (e, st) {
      log('payWithFawry error: $e\n$st');
      return left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> subscribeToCourse({
    required CourseEntity course,
    required UserEntity userEntity,
  }) async {
    try {
      final Subscriberentity subscriber =
          getSubscriberEntity(userEntity: userEntity);

      await Future.wait([
        addCourseToMyCourseList(course: course, userEntity: userEntity),
        addNewSubscriber(
          subscriber,
          getFireStoreRequirmentsEntity(courseId: course.id),
        ),
        updateSubscribersCount(courseId: course.id),
      ]);

      return right(null);
    } on CustomException catch (e) {
      await deleteCourseFromMyCourseList(
          course: course, userEntity: userEntity);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      await deleteCourseFromMyCourseList(
          course: course, userEntity: userEntity);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<void> updateSubscribersCount({
    required String courseId,
    int delta = 1,
  }) async {
    try {
      await datebaseservice.updateData(
        collectionKey: BackendEndpoints.coursesCollection,
        field: "studentsCount",
        doc: courseId,
        data: FieldValue.increment(delta),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addNewSubscriber(
    Subscriberentity subscriberentity,
    FireStoreRequirmentsEntity fireStoreRequirmentsEntity,
  ) async {
    final Map<String, dynamic> json =
        Subscripersidsmodel.fromEntit(subscriberentity: subscriberentity)
            .toJson();

    await datebaseservice.setData(
      data: json,
      requirements: fireStoreRequirmentsEntity,
    );
  }

  Subscriberentity getSubscriberEntity({required UserEntity userEntity}) {
    return Subscriberentity(
      id: getUID(),
      name: userEntity.firstName,
      gender: userEntity.gender,
      phone: userEntity.phoneNumber,
      educationLevel: userEntity.studentExtraDataEntity?.educationLevel ?? " ",
      imageUrl: userEntity.profilePicurl,
      address: userEntity.address,
    );
  }

  FireStoreRequirmentsEntity getFireStoreRequirmentsEntity({
    required String courseId,
  }) {
    return FireStoreRequirmentsEntity(
      collection: BackendEndpoints.coursesCollection,
      docId: courseId,
      subDocId: getUID(),
      subCollection: BackendEndpoints.subscribersSubCollection,
    );
  }

  Future<void> addCourseToMyCourseList({
    required CourseEntity course,
    required UserEntity userEntity,
  }) async {
    final Map<String, dynamic> json =
        Coursemodel.fromEntity(courseEntity: course).toJson();

    await datebaseservice.setData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userEntity.uid,
        subDocId: course.id,
        subCollection: BackendEndpoints.subscribetoCourseCollection,
      ),
      data: json,
    );
  }

  Future<bool> checkIsCourseAddedToMyCourseList({
    required CourseEntity course,
    required UserEntity userEntity,
  }) async {
    return await datebaseservice.isDataExists(
      key: BackendEndpoints.usersCollectionName,
      docId: userEntity.uid,
      subDocId: course.id,
      subCollectionKey: BackendEndpoints.subscribetoCourseCollection,
    );
  }

  Future<void> deleteCourseFromMyCourseList({
    required CourseEntity course,
    required UserEntity userEntity,
  }) async {
    final bool isAdded = await checkIsCourseAddedToMyCourseList(
      course: course,
      userEntity: userEntity,
    );
    if (isAdded) {
      await datebaseservice.deleteDoc(
        collectionKey: BackendEndpoints.usersCollectionName,
        docId: userEntity.uid,
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
      final bool isSubscribed = await datebaseservice.isDataExists(
        key: BackendEndpoints.usersCollectionName,
        subCollectionKey: BackendEndpoints.checkifSubscribedSubCollection,
        docId: userID,
        subDocId: courseID,
      );
      return right(isSubscribed);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  DocumentSnapshot? _getCourseSubscribersLastDoc;
  final Map<String, dynamic> _baseGetCourseSubscribersQuery = {
    "startAfter": null,
    "limit": 10,
  };
  @override
  Future<Either<Failure, GetCourseSubscribersEntity>> getSubscribers({
    required String courseID,
    required bool isPaginate,
  }) async {
    try {
      final Map<String, dynamic> query =
          Map<String, dynamic>.from(_baseGetCourseSubscribersQuery);
      query["startAfter"] = isPaginate ? _getCourseSubscribersLastDoc : null;

      final FireStoreResponse response = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          subCollection: BackendEndpoints.subscribersSubCollection,
          docId: courseID,
        ),
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }

      if (response.listData!.isEmpty) {
        // no data
        return right(GetCourseSubscribersEntity(
            subscribers: [], hasMore: false, isPaginate: isPaginate));
      }

      if (response.lastDocumentSnapshot != null) {
        _getCourseSubscribersLastDoc = response.lastDocumentSnapshot;
      }

      final List<Subscriberentity> subscribers =
          await compute<List<dynamic>, List<Subscriberentity>>(
              _parseSubscribers, response.listData!);

      final bool hasMore = response.hasMore ?? false;

      return right(GetCourseSubscribersEntity(
          subscribers: subscribers, hasMore: hasMore, isPaginate: isPaginate));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, st) {
      log('getSubscribers error: $e\n$st');
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}

List<Subscriberentity> _parseSubscribers(List<dynamic> rawList) {
  return rawList
      .map((e) => Subscripersidsmodel.fromJson(e).toEntity())
      .toList();
}
