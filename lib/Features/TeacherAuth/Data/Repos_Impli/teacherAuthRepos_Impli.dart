// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherAuth/Data/Models/TeacherModel.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

class teacherAuthRepos_Impli implements TeacherAuthRepos {
  final firebaseAuthService authService;
  final StorageService storageService;
  final Databaseservice dataBaseService;
  teacherAuthRepos_Impli(
      {required this.dataBaseService,
      required this.storageService,
      required this.authService});
  @override
  Future<Either<Failure, void>> createUserWithEmailAndPassword(
      {required teacherEntity teacherEntity, required String password}) async {
    User? user;
    try {
      user = await authService.createUserWithEmailAndPassword(
          teacherEntity.email, password, teacherEntity.firstName);
      teacherEntity.uid = user.uid;
      Teachermodel teacherModel =
          Teachermodel.fromEntity(teacherentity: teacherEntity);
      await addTeacherData(
          key: BackendEndpoints.addTeacherDataCollectionName,
          data: teacherModel.toMap(),
          docId: user.uid);
      await authService.auth.currentUser!.sendEmailVerification();
      return right(null);
    } on CustomException catch (e) {
      DeleteUser(user);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      DeleteUser(user);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePoc(
      {required File image}) async {
    try {
      String url = await storageService.uploadFile(file: image);
      return right(url);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from teacherAuthRepos_Impli.uploadProfilePoc in catch With Firebase Exception: ${e.toString()} ");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<void> addTeacherData(
      {required String key,
      required Map<String, dynamic> data,
      required String docId}) async {
    await dataBaseService.setData(
      requirements: FireStoreRequirmentsEntity(
        collection: key,
        docId: docId,
      ),
      data: data,
    );
  }

  Future<void> DeleteUser(User? user) async {
    if (user != null) {
      await authService.deleteUSer();
      await teacherSignout();
    }
  }

  @override
  Future<Either<Failure, teacherEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    User? user;
    try {
      user = await authService.signInWithEmailAndPassword(email, password);
      teacherEntity? teacherentity = await getTeacherData(docId: user.uid);

      if (user.emailVerified == true) {
        if (teacherentity != null) {
          if (teacherentity.state == BackendEndpoints.agreed) {
            await shared_preferences_Services.stringSetter(
                value: "teacher", key: BackendEndpoints.userKind);
            return right(teacherentity);
          } else if (teacherentity.state == BackendEndpoints.waiting) {
            await teacherSignout();
            return left(
                ServerFailure(message: "الطلب قيد المراجعة من قبل الادارة"));
          } else if (teacherentity.state == BackendEndpoints.rejected) {
            await teacherSignout();
            return left(ServerFailure(message: "تم رفض طلبك من قبل الادارة"));
          } else {
            await teacherSignout();
            return left(ServerFailure(message: "حدث خطأ ما"));
          }
        } else {
          await teacherSignout();
          return left(ServerFailure(message: "هذا المعلم غير مسجل في التطبيق"));
        }
      } else {
        await teacherSignout();
        return left(ServerFailure(message: "يرجى التحقق من بريدك الالكتروني"));
      }
    } on CustomException catch (e) {
      await teacherSignout();
      return left(ServerFailure(message: e.toString()));
    } catch (e) {
      await teacherSignout();
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<void> teacherSignout() async {
    await authService.signout();
  }

  @override
  Future getTeacherData({required String docId}) async {
    FireStoreResponse? data = await dataBaseService.getData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.getTeacherDataCollectionName,
        docId: docId,
      ),
    );
    if (data.docData != null) {
      teacherEntity teacherentity =
          Teachermodel.fromMap(data.docData!).toEntity();
      return teacherentity;
    } else {
      null;
    }
  }
}
