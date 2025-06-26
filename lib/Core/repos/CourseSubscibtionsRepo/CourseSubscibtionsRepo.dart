// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/SubscriberEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/teacherEntity.dart';

abstract class CourseSubscibtionsRepo {
  Future<Either<Failure, String>> payWithFawry(
      {required Paymentdataentity paymententity,
      required Orderdataentity orderEntity});
  Future<Either<Failure, void>> subscribeToCourse(
      {required CourseEntity course,
      teacherEntity? teacher,
      Studententity? student});
  Future<Either<Failure, bool>> checkIfSubscribed(
      {required String userID, required String courseID});
  Future<Either<Failure, List<Subscriberentity>>> getSubscribers(
      {required String courseID});
}
