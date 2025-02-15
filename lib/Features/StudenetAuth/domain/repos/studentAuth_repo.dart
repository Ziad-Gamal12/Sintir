// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';

abstract class StudentauthRepo {
  Future<Either<Failure, void>> createUserWithEmailAndPassword(
      {required Studententity studentEntity, required String password});
  Future<void> addUserToDatabase(
      {required Map<String, dynamic> data,
      required String docId,
      required String key});
  Future<Either<Failure, void>> sginInWithEmailAndPasswoed(
      {required String email, required String password});
  Future<Either<Failure, void>> signinWithGoogle();
  Future<Either<Failure, void>> signinWithFaceBook();
  Future<Either<Failure, void>> signinWithApple();
  Future<void> deleteUser({required User? user});
}
