// ignore_for_file: file_names

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
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

class CourseSubscibtionsRepoimpli implements CourseSubscibtionsRepo {
  final PayMobService payMobService;
  final Databaseservice datebaseservice;

  CourseSubscibtionsRepoimpli(
      {required this.datebaseservice, required this.payMobService});

  Future<int?> createPaymentOrder(
      {required Orderdataentity orderEntity}) async {
    int? id = await payMobService.createPaymentOrder(orderEntity: orderEntity);
    return id;
  }

  Future<String?> getAuthToken() async {
    String? token = await payMobService.getAuthToken();
    return token;
  }

  Future<String> getPaymentToken(
      {required Paymentdataentity paymententity}) async {
    String token =
        await payMobService.getPaymentToken(paymententity: paymententity);
    return token;
  }

  @override
  Future<Either<Failure, String>> payWithFawry(
      {required Paymentdataentity paymententity,
      required Orderdataentity orderEntity}) async {
    try {
      String? authtoken = await getAuthToken();
      if (authtoken == null) {
        return Left(
            ServerFailure(message: "حدث خطأ أثناء الحصول على التوكن الخاص بك"));
      } else {
        orderEntity.authToken = authtoken;
        paymententity.authToken = authtoken;
      }
      int? paymentToken = await createPaymentOrder(orderEntity: orderEntity);
      if (paymentToken == null) {
        return Left(ServerFailure(message: "حدث خطاء في انشاء الطلبية"));
      } else {
        paymententity.orderId = paymentToken;
      }
      log(Paymentdatamodel.formEntity(paymententity).toJson().toString());
      String token = await getPaymentToken(paymententity: paymententity);
      return right(token);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> subscribeToCourse(
      {required CourseEntity course, required UserEntity userEntity}) async {
    try {
      Subscriberentity subscriber = getSubscriberEntity(userEntity: userEntity);
      await Future.wait([
        addCourseToMyCourseList(
          course: course,
          userEntity: userEntity,
        ),
        addNewSubscriber(
            subscriber,
            getFireStoreRequirmentsEntity(
              courseId: course.id,
            )),
      ]);
      return right(null);
    } on CustomException catch (e) {
      await deleteCourseFromMyCourseList(
        course: course,
        userEntity: userEntity,
      );
      return left(ServerFailure(message: e.message));
    } catch (e) {
      await deleteCourseFromMyCourseList(
        course: course,
        userEntity: userEntity,
      );
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<void> addNewSubscriber(
    Subscriberentity subscriberentity,
    FireStoreRequirmentsEntity fireStoreRequirmentsEntity,
  ) async {
    await datebaseservice.setData(
      data: Subscripersidsmodel.fromEntit(subscriberentity: subscriberentity)
          .toJson(),
      requirements: fireStoreRequirmentsEntity,
    );
  }

  Subscriberentity getSubscriberEntity({required UserEntity userEntity}) {
    return Subscriberentity(
        id: getUID(),
        name: userEntity.firstName,
        gender: userEntity.gender,
        phone: userEntity.phoneNumber,
        educationLevel:
            userEntity.studentExtraDataEntity?.educationLevel ?? " ",
        imageUrl: userEntity.profilePicurl,
        address: userEntity.address);
  }

  FireStoreRequirmentsEntity getFireStoreRequirmentsEntity({
    required String courseId,
  }) {
    return FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subDocId: getUID(),
        subCollection: BackendEndpoints.subscribersSubCollection);
  }

  Future<void> addCourseToMyCourseList(
      {required CourseEntity course, required UserEntity userEntity}) async {
    await datebaseservice.setData(
      requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userEntity.uid,
          subDocId: course.id,
          subCollection: BackendEndpoints.subscribetoCourseCollection),
      data: Coursemodel.fromEntity(courseEntity: course).toJson(),
    );
  }

  Future<bool> checkIsCourseAddedToMyCourseList(
      {required CourseEntity course, required UserEntity userEntity}) async {
    return await datebaseservice.isDataExists(
        key: BackendEndpoints.usersCollectionName,
        docId: userEntity.uid,
        subDocId: course.id,
        subCollectionKey: BackendEndpoints.subscribetoCourseCollection);
  }

  Future<void> deleteCourseFromMyCourseList(
      {required CourseEntity course, required UserEntity userEntity}) async {
    bool isAdded = await checkIsCourseAddedToMyCourseList(
        course: course, userEntity: userEntity);
    if (isAdded) {
      await datebaseservice.deleteDoc(
          collectionKey: BackendEndpoints.usersCollectionName,
          docId: userEntity.uid,
          subDocId: course.id,
          subCollectionKey: BackendEndpoints.subscribetoCourseCollection);
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfSubscribed(
      {required String userID, required String courseID}) async {
    try {
      bool isSubscribed = await datebaseservice.isDataExists(
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

  @override
  Future<Either<Failure, List<Subscriberentity>>> getSubscribers(
      {required String courseID}) async {
    try {
      FireStoreResponse response = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          subCollection: BackendEndpoints.subscribersSubCollection,
          docId: courseID,
        ),
      );
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right([]);
      }
      return right(
        response.listData!
            .map((e) => Subscripersidsmodel.fromJson(e).toEntity())
            .toList(),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
