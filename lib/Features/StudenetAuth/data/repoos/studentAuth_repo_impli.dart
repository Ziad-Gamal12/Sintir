// ignore_for_file: file_names

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
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
  Future<Either<Failure, void>> createUserWithEmailAndPassword(
      {required Studententity studentEntity, required String password}) async {
    User? user;
    try {
      user = await firebaseAuth.createUserWithEmailAndPassword(
          studentEntity.email, password, studentEntity.firstName);
      studentEntity.uid = user.uid;
      StudentauthModel studententity = StudentauthModel.fromEntity(
        studententity: studentEntity,
      );
      bool isPhoneNumberExist = await datebaseservice.isFeildExists(
          key: BackendEndpoints.chieckIsStudentPhoneNumberExistCollectionName,
          feild: "phoneNumber",
          feildValue: studentEntity.phoneNumber);
      if (!isPhoneNumberExist) {
        await addUserToDatabase(
            data: studententity.toMap(),
            docId: user.uid,
            key: BackendEndpoints.addStudentDataCollectionName);
        return right(null);
      } else {
        deleteUser(user: user);
        return left(ServerFailure(message: "هذا الرقم مستخدم من قبل"));
      }
    } on CustomException catch (e) {
      deleteUser(user: user);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from studentAuthRepo.createUserWithEmailAndPassword in catch With Firebase Exception: ${e.toString()}");
      deleteUser(user: user);
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> sginInWithEmailAndPasswoed(
      {required String email, required String password}) async {
    User? user;
    try {
      user = await firebaseAuth.signInWithEmailAndPassword(email, password);
      bool isExists = await datebaseservice.isDataExists(
          key: BackendEndpoints.checkIsStudentExistCollectionName,
          docId: user.uid);
      if (isExists) {
        await shared_preferences_Services.stringSetter(
            value: "stundent", key: BackendEndpoints.userKind);
        return right(null);
      } else {
        signout(user);
        return left(ServerFailure(message: "خطأ في البيانات"));
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      signout(user);
      log("Exception from studentAuthRepo.sginInWithEmailAndPasswoed in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> signinWithGoogle() async {
    User? user;
    bool? isExist;
    try {
      user = await firebaseAuth.signinWithGoogle();
      isExist = await datebaseservice.isDataExists(
          key: BackendEndpoints.checkIsStudentExistCollectionName,
          docId: user.uid);
      if (!isExist) {
        StudentauthModel studentauthmodel =
            StudentauthModel.fromFirebase(user: user);
        await addUserToDatabase(
            data: studentauthmodel.toMap(),
            docId: user.uid,
            key: BackendEndpoints.addStudentDataCollectionName);
        await shared_preferences_Services.stringSetter(
            value: "stundent", key: BackendEndpoints.userKind);
        return right(null);
      } else {
        await shared_preferences_Services.stringSetter(
            value: "stundent", key: BackendEndpoints.userKind);

        return right(null);
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from studentAuthRepo_Impli.signinWithGoogle in catch With Firebase Exception: ${e.toString()}");
      if (isExist == false) {
        deleteUser(user: user);
      } else {
        signout(user);
      }
      return left(ServerFailure(message: "خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> signinWithFaceBook() async {
    User? user;
    bool? isExist;
    try {
      user = await firebaseAuth.signinWithFacebook();
      isExist = await datebaseservice.isDataExists(
          key: BackendEndpoints.checkIsStudentExistCollectionName,
          docId: user.uid);
      if (!isExist) {
        StudentauthModel studentauthmodel =
            StudentauthModel.fromFirebase(user: user);
        await addUserToDatabase(
            data: studentauthmodel.toMap(),
            docId: user.uid,
            key: BackendEndpoints.addStudentDataCollectionName);
        await shared_preferences_Services.stringSetter(
            value: "stundent", key: BackendEndpoints.userKind);

        return right(null);
      } else {
        await shared_preferences_Services.stringSetter(
            value: "stundent", key: BackendEndpoints.userKind);

        return right(null);
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from studentAuthRepo_Impli.signinWithFaceBook in catch With Firebase Exception: ${e.toString()}");
      if (isExist == false) {
        deleteUser(user: user);
      } else {
        signout(user);
      }
      return left(ServerFailure(message: "خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> signinWithApple() async {
    User? user;
    bool? isExist;
    try {
      user = await firebaseAuth.signInWithApple();
      StudentauthModel studentauthmodel =
          StudentauthModel.fromFirebase(user: user);
      isExist = await datebaseservice.isDataExists(
          key: BackendEndpoints.checkIsStudentExistCollectionName,
          docId: user.uid);
      if (!isExist) {
        await addUserToDatabase(
            data: studentauthmodel.toMap(),
            docId: user.uid,
            key: BackendEndpoints.addStudentDataCollectionName);
        await shared_preferences_Services.stringSetter(
            value: "stundent", key: BackendEndpoints.userKind);

        return right(null);
      } else {
        await shared_preferences_Services.stringSetter(
            value: "stundent", key: BackendEndpoints.userKind);

        return right(null);
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from teacherAuthRepos_Impli.signinWithGoogle in catch With Firebase Exception: ${e.toString()}");
      if (isExist == false) {
        deleteUser(user: user);
      } else {
        signout(user);
      }
      return left(ServerFailure(message: "خطأ ما"));
    }
  }

  Future<void> signout(User? user) async {
    if (user != null) {
      await firebaseAuth.signout();
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
    await datebaseservice.setData(
      requirements: FireStoreRequirmentsEntity(
        collection: key,
        docId: docId,
      ),
      data: data,
    );
  }
}
