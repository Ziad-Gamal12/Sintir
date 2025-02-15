import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/services/sqfliteServices.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/StudenetAuth/data/model/studentAuth_model.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Data/Models/TeacherModel.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

Future<Studententity?> getStudentData() async {
  String? userUid = getUserUid();
  if (userUid == null) return null;

  List<Map<String, Object?>> userData = await Sqfliteservices().readData(
      tableName: BackendEndpoints.setStudentDataTableName, rawID: userUid);

  if (userData.isEmpty) return null;

  StudentauthModel studentauthModel =
      StudentauthModel.fromJson(data: userData[0]);
  return studentauthModel.toEntity();
}

Future<teacherEntity?> getTeacherData() async {
  String? userUid = getUserUid();
  if (userUid == null) return null;

  List<Map<String, Object?>> userData = await Sqfliteservices()
      .readData(tableName: "Teachers", rawID: "U5POjCoz0sgWBir26q8MoXdvDhJ2")
      .then((value) {
    log(value.toString());
    return value;
  });

  if (userData.isEmpty) return null;

  Teachermodel teachermodel = Teachermodel.fromMap(userData[0]);
  return teachermodel.toEntity();
}

String? getUserUid() {
  return FirebaseAuth.instance.currentUser?.uid;
}
