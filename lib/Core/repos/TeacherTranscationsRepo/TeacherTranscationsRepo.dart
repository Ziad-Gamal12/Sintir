import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class TeacherTranscationsRepo {
  Future<Either<Failure, void>> storeTransaction(
      {required TransactionEntity transaction, required String userId});

  Future<Either<Failure, void>> reconcileTransaction(
      {required TransactionEntity transaction,
      required String userId,
      required String newStatus});
  Future<void> reStoreTransactionAfterFailure(
      {required double amount, required String userId});
  Future<void> deducteFromTeacherWallet(
      {required double amount, required String userId});
  Future<void> updateTransactionStatus(
      {required String userId,
      required String status,
      required String transactionId});
  Future<void> updateTransactionIsReconciled(
      {required String userId,
      required bool value,
      required String transactionId});
}
