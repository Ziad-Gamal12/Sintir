import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWithdrawalResultEntity.dart';

abstract class WithDrawalTeacherBalanceRepo {
  Future<Either<Failure, TeacherWithdrawalResultEntity>> requestWithdrawal(
      {required double amount,
      required String issuer,
      required String mobileNumber,
      required String idempotencyKey});
  Future<Either<Failure, TeacherWithdrawalResultEntity>> reconcileWithdrawal(
      {required String withdrawalId});
}
