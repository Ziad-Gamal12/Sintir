// ignore_for_file: camel_case_types, file_names, non_constant_identifier_names

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/FirebaseStorageService.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/services/sqfliteServices.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherAuth/Data/Models/TeacherModel.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

class teacherAuthRepos_Impli implements TeacherAuthRepos {
  final firebaseAuthService authService;
  final firebasestorageservice firebaseStorageService;
  final Datebaseservice dataBaseService;
  final Sqfliteservices sqfliteservices;
  teacherAuthRepos_Impli(
      {required this.dataBaseService,
      required this.sqfliteservices,
      required this.firebaseStorageService,
      required this.authService});
  @override
  Future<Either<Failure, teacherEntity>> createUserWithEmailAndPassword({
    required String email,
    required String password,
    required String name,
    required String firstName,
    required String lastName,
    required String address,
    required String phoneNumber,
    required String subject,
    required String workExperience,
    required String gender,
    required String profilePicurl,
    required String state,
  }) async {
    User? user;
    try {
      user = await authService.createUserWithEmailAndPassword(
          email, password, name);
      var teacherentity = Teachermodel.fromFirebase(
          user: user,
          firstName: firstName,
          lastName: lastName,
          address: address,
          phoneNumber: phoneNumber,
          subject: subject,
          workExperience: workExperience,
          gender: gender,
          profilePicurl: profilePicurl,
          state: state);
      await addTeacherData(
          key: BackendEndpoints.addTeacherDataCollectionName,
          data: teacherentity.toMap(),
          docId: user.uid);
      await authService.auth.currentUser!.sendEmailVerification();
      return right(teacherentity);
    } on CustomException catch (e) {
      DeleteUser(user);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from teacherAuthRepos_Impli.createUserWithEmailAndPassword in catch With Firebase Exception: ${e.toString()}");
      DeleteUser(user);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePoc(
      {required ImageSource source}) async {
    try {
      String url = await firebaseStorageService.uploadImage(source: source);
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
    await dataBaseService.setData(key: key, data: data, docId: docId);
  }

  Future<void> DeleteUser(User? user) async {
    if (user != null) {
      await authService.deleteUSer();
    }
  }

  @override
  Future<Either<Failure, teacherEntity>> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    User? user;
    try {
      user = await authService.signInWithEmailAndPassword(email, password);
      var teacherentity = await getTeacherData(docId: user.uid);
      if (authService.auth.currentUser!.emailVerified) {
        if (teacherentity != null) {
          if (teacherentity.stete == BackendEndpoints.agreed) {
            await saveTeacherData(teacherentity: teacherentity);
            await shared_preferences_Services.stringSetter(
                value: "stundent", key: BackendEndpoints.userKind);

            return right(teacherentity);
          } else if (teacherentity.stete == BackendEndpoints.waiting) {
            await teacherSignout(user);
            return left(
                ServerFailure(message: "الطالب قيد المراجعة من قبل الادارة"));
          } else if (teacherentity.stete == BackendEndpoints.rejected) {
            await teacherSignout(user);
            return left(ServerFailure(message: "تم رفض طلبك من قبل الادارة"));
          } else {
            await teacherSignout(user);
            return left(ServerFailure(message: "حدث خطأ ما"));
          }
        } else {
          await teacherSignout(user);
          return left(ServerFailure(message: "هذا المعلم غير مسجل في التطبيق"));
        }
      } else {
        await authService.auth.currentUser!.sendEmailVerification();
        await teacherSignout(user);
        return left(ServerFailure(message: "التحقق من صحة البريد الالكتروني"));
      }
    } on CustomException catch (e) {
      await teacherSignout(user);
      return left(ServerFailure(message: e.toString()));
    } catch (e) {
      log("Exception from teacherAuthRepos_Impli.signInWithEmailAndPassword in catch With Firebase Exception: ${e.toString()}");
      await teacherSignout(user);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<void> teacherSignout(User? user) async {
    if (user != null) {
      await authService.signout();
    }
  }

  @override
  Future getTeacherData({required String docId}) async {
    var data = await dataBaseService.getData(
        key: BackendEndpoints.getTeacherDataCollectionName, docId: docId);
    if (data != null) {
      teacherEntity teacherentity = Teachermodel.fromMap(data);
      return teacherentity;
    } else {
      return null;
    }
  }

  @override
  Future<void> saveTeacherData({required teacherEntity teacherentity}) async {
    await sqfliteservices.insertData(
        tableName: BackendEndpoints.setTeacherDataTableName,
        data: Teachermodel.fromEntity(teacherentity: teacherentity).toMap());
  }
}
