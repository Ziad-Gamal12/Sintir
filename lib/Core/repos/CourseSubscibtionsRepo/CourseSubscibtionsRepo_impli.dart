// ignore_for_file: file_names

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/entities/SubscriberEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/models/PaymentModels/OrderDataModel.dart';
import 'package:sintir/Core/models/PaymentModels/PaymentDataModel.dart';
import 'package:sintir/Core/models/subscripersIDSModel.dart';
import 'package:sintir/Core/repos/CourseSubscibtionsRepo/CourseSubscibtionsRepo.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/PayMobService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

class CourseSubscibtionsRepoimpli implements CourseSubscibtionsRepo {
  final PayMobService payMobService;
  final Datebaseservice datebaseservice;

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
        log(Orderdatamodel.fromEntity(orderEntity).toJson().toString());
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
      log("Exception from PaymentrepoImpli.payWithFawry in catch With Firebase Exception: ${e.toString()}");
      return Left(ServerFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> subscribeToCourse(
      {required CourseEntity course,
      teacherEntity? teacher,
      Studententity? student}) async {
    try {
      await addCourseToMyCourseList(teacher, course, student);
      if (teacher != null) {
        Subscriberentity teacherSubscriber = Subscriberentity(
            id: teacher.uid!,
            name: teacher.firstName,
            gender: teacher.gender,
            phone: teacher.phoneNumber,
            educationLevel: "",
            imageUrl: teacher.profilePicurl!,
            address: teacher.address);
        await datebaseservice.setData(
          data:
              Subscripersidsmodel.fromEntit(subscriberentity: teacherSubscriber)
                  .toJson(),
          json: {
            "mainCollection": BackendEndpoints.coursesCollection,
            "docId": course.id,
            "subDocId": teacher.uid,
            "subCollection": BackendEndpoints.subscribersSubCollection
          },
        );
      } else if (student != null) {
        Subscriberentity studentSubscriber = Subscriberentity(
            id: student.uid!,
            name: student.firstName,
            gender: student.gender,
            phone: student.phoneNumber,
            educationLevel: student.educationLevel,
            imageUrl: student.imageUrl,
            address: "");
        await datebaseservice.setData(
          data:
              Subscripersidsmodel.fromEntit(subscriberentity: studentSubscriber)
                  .toJson(),
          json: {
            "mainCollection": BackendEndpoints.coursesCollection,
            "docId": course.id,
            "subDocId": student.uid,
            "subCollection": BackendEndpoints.subscribersSubCollection
          },
        );
      } else {
        await deleteCourseFromMyCourseList(teacher, course, student);
        return left(ServerFailure(message: "حدث خطاء في انشاء الطلبية"));
      }
      return right(null);
    } on CustomException catch (e) {
      await deleteCourseFromMyCourseList(teacher, course, student);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from CoursesrepoImpl.addCourse in catch With Firebase Exception: ${e.toString()}");
      await deleteCourseFromMyCourseList(teacher, course, student);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<void> addCourseToMyCourseList(teacherEntity? teacher,
      CourseEntity course, Studententity? student) async {
    await datebaseservice.setData(
      json: {
        "mainCollection": teacher == null
            ? BackendEndpoints.studentsCollection
            : BackendEndpoints.teachersCollection,
        "docId": teacher == null ? student!.uid : teacher.uid,
        "subDocId": course.id,
        "subCollection": BackendEndpoints.subscribetoCourseCollection
      },
      data: Coursemodel.fromEntity(courseEntity: course).toJson(),
    );
  }

  Future<void> updateSubscribersIdsList(CourseEntity course) async {}

  Future<bool> checkIsCourseAddedToMyCourseList(teacherEntity? teacher,
      CourseEntity course, Studententity? student) async {
    return await datebaseservice.isDataExists(
        key: teacher == null
            ? BackendEndpoints.studentsCollection
            : BackendEndpoints.teachersCollection,
        docId: teacher == null ? student!.uid ?? "" : teacher.uid ?? "",
        subDocId: course.id,
        subCollectionKey: BackendEndpoints.subscribetoCourseCollection);
  }

  Future<void> deleteCourseFromMyCourseList(teacherEntity? teacher,
      CourseEntity course, Studententity? student) async {
    bool isAdded =
        await checkIsCourseAddedToMyCourseList(teacher, course, student);
    if (isAdded) {
      await datebaseservice.deleteDoc(
          collectionKey: teacher == null
              ? BackendEndpoints.studentsCollection
              : BackendEndpoints.teachersCollection,
          docId: teacher == null ? student!.uid ?? "" : teacher.uid ?? "",
          subDocId: course.id,
          subCollectionKey: BackendEndpoints.subscribetoCourseCollection);
    }
  }

  @override
  Future<Either<Failure, bool>> checkIfSubscribed(
      {required String userID, required String courseID}) async {
    try {
      bool isSubscribed = await datebaseservice.isDataExists(
        key: BackendEndpoints.checkifSubscribedCollection,
        subCollectionKey: BackendEndpoints.checkifSubscribedSubCollection,
        docId: courseID,
        subDocId: userID,
      );
      return right(isSubscribed);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
