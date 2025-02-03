import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';

abstract class TeacherAuthRepos {
  Future<Either<Failure, void>> createUserWithEmailAndPassword(
      {required teacherEntity teacherEntity, required String password});
  Future<Either<Failure, String>> uploadProfilePoc({required File image});
  Future<void> addTeacherData(
      {required String key,
      required Map<String, dynamic> data,
      required String docId});
  Future<Either<Failure, void>> signInWithEmailAndPassword(
      {required String email, required String password});
  Future getTeacherData({required String docId});
  Future<void> saveTeacherData({
    required teacherEntity teacherentity,
  });
}
