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
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherAuth/Data/Models/TeacherModel.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

class teacherAuthRepos_Impli implements TeacherAuthRepos {
  final firebaseAuthService authService;
  final firebasestorageservice firebaseStorageService;
  final Datebaseservice dataBaseService;
  teacherAuthRepos_Impli(
      {required this.dataBaseService,
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
      teacherEntity teacherentity = Teachermodel.fromFirebase(
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
  Future<void> deleteImage({required String url}) async {
    await firebaseStorageService.deleteImage(url: url);
  }
}
