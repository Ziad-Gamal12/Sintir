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

  Future<void> deleteUser({required User? user});
}
