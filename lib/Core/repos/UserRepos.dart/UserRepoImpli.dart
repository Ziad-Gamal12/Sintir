import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/UserEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/UserRepos.dart/userRepo.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/StudenetAuth/data/model/studentAuth_model.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Data/Models/TeacherModel.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

class Userrepoimpli implements Userrepo {
  final Datebaseservice datebaseservicel;

  Userrepoimpli({required this.datebaseservicel});
  @override
  Future<Either<Failure, UserEntity>> getUserData() async {
    try {
      Map<String, dynamic>? data = await datebaseservicel.getData(
          key: getCollectionName(), docId: getDocId());

      if (data == null) return left(ServerFailure(message: "لا يوجد مستخدم"));
      if (shared_preferences_Services.stringGetter(
              key: BackendEndpoints.userKind) ==
          "teacher") {
        teacherEntity? teacherentity = Teachermodel.fromMap(data).toEntity();
        return right(UserEntity(teacher: teacherentity));
      } else {
        Studententity? studentEntity =
            StudentauthModel.fromJson(data: data).toEntity();
        return right(UserEntity(student: studentEntity));
      }
    } catch (e) {
      log("Exception from UserRepo.getUserData in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  String getCollectionName() {
    String role = shared_preferences_Services.stringGetter(
        key: BackendEndpoints.userKind);
    if (role == "teacher") {
      return BackendEndpoints.getTeacherDataCollectionName;
    } else {
      return BackendEndpoints.getStudentDataCollectionName;
    }
  }

  String getDocId() {
    if (FirebaseAuth.instance.currentUser == null) {
      return "";
    } else {
      return FirebaseAuth.instance.currentUser!.uid;
    }
  }
}
