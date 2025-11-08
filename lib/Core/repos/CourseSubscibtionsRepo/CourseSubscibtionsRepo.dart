// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseSubscribersEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

abstract class CourseSubscibtionsRepo {
  Future<Either<Failure, void>> subscribeToCourse(
      {required CourseEntity course,
      required double amount,
      required UserEntity userEntity,
      required String transactionId});
  Future<Either<Failure, bool>> checkIfSubscribed(
      {required String userID, required String courseID});
  Future<Either<Failure, GetCourseSubscribersEntity>> getSubscribers(
      {required String courseID, required bool isPaginate});
  Future<Either<Failure, GetCourseSubscribersEntity>> searchSubscribers(
      {required String courseID,
      required String searchKey,
      required bool isPaginate});
  Future<Either<Failure, int>> getSubscribersCount({required String courseID});
}
