import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/FirebaseAuth_Service.dart';
import 'package:sintir/Core/services/FirebaseStorageService.dart';
import 'package:sintir/Features/TeacherAuth/Data/Models/TeacherModel.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

class teacherAuthRepos_Impli implements TeacherAuthRepos {
  final firebaseAuthService authService;
  final firebasestorageservice firebaseStorageService;
  teacherAuthRepos_Impli(
      {required this.firebaseStorageService, required this.authService});
  @override
  Future<Either<Failure, teacherEntity>> createUserWithEmailAndPassword(
      {required String email,
      required String password,
      required String name}) async {
    try {
      User user = await authService.createUserWithEmailAndPassword(
          email, password, name);
      return right(Teachermodel.fromFirebase(user: user));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadProfilePoc(
      {required ImageSource source}) async {
    try {
      String url = await firebaseStorageService.uploadFile(source: source);
      return right(url);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from teacherAuthRepos_Impli.uploadProfilePoc in catch With Firebase Exception: ${e.toString()} ");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
