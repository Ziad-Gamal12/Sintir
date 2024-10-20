// ignore_for_file: file_names

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/StudenetAuth/data/model/studentAuth_model.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';

class StudentauthRepoImpli implements StudentauthRepo {
  final firebaseAuthService firebaseAuth;
  final Datebaseservice datebaseservice;
  StudentauthRepoImpli(
      {required this.firebaseAuth, required this.datebaseservice});
  @override
  Future<Either<Failure, Studententity>> createUserWithEmailAndPassword(
      {required Studententity studentEntity}) async {
    User? user;
    try {
      user = await firebaseAuth.createUserWithEmailAndPassword(
          studentEntity.email, studentEntity.password, studentEntity.firstName);
      var studententity = StudentauthModel.fromUserAndEntity(
          studententity: studentEntity, user: user);
      bool isPhoneNumberExist = await datebaseservice.isFeildExists(
          key: BackendEndpoints.chieckIsStudentPhoneNumberExistCollectionName,
          feild: "phoneNumber",
          feildValue: studentEntity.phoneNumber);
      if (!isPhoneNumberExist) {
        await addUserToDatabase(
            data: studententity.toMap(),
            docId: user.uid,
            key: BackendEndpoints.addStudentDataCollectionName);
        return right(studententity);
      } else {
        deleteUser(user: user);
        return left(ServerFailure(message: "هذا الرقم مستخدم من قبل"));
      }
    } on CustomException catch (e) {
      deleteUser(user: user);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from teacherAuthRepos_Impli.createUserWithEmailAndPassword in catch With Firebase Exception: ${e.toString()}");
      deleteUser(user: user);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<void> deleteUser({required User? user}) async {
    if (user != null) {
      firebaseAuth.deleteUSer();
    }
  }

  @override
  Future<void> addUserToDatabase(
      {required Map<String, dynamic> data,
      required String docId,
      required String key}) async {
    await datebaseservice.setData(data: data, docId: docId, key: key);
  }
}
