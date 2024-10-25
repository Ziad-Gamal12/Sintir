// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';

abstract class StudentauthRepo {
  Future<Either<Failure, Studententity>> createUserWithEmailAndPassword(
      {required Studententity studentEntity});
  Future<void> addUserToDatabase(
      {required Map<String, dynamic> data,
      required String docId,
      required String key});
  Future<Either<Failure, Studententity>> sginInWithEmailAndPasswoed(
      {required String email, required String password});
  Future<Studententity> getStudentData(
      {required String docId, required String key});
  Future<Either<Failure, Studententity>> signinWithGoogle();
  Future<Either<Failure, Studententity>> signinWithFaceBook();
  Future<Either<Failure, Studententity>> signinWithApple();

  Future<void> deleteUser({required User? user});
  Future<void> saveStudentData({required Studententity studententity});
}
