import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/TeacherTranscationsRepo/TeacherTranscationsRepo.dart';

class TeacherTranscationsRepoImpl implements TeacherTranscationsRepo {
  TeacherTranscationsRepoImpl();

  @override
  Future<Either<Failure, void>> storeTransaction(
      {required TransactionEntity transaction, required String userId}) async {
    return left(ServerFailure(
      message: 'Financial transactions can only be created by the server.',
    ));
  }

  @override
  Future<Either<Failure, void>> reconcileTransaction(
      {required TransactionEntity transaction,
      required String userId,
      required String newStatus}) async {
    return left(ServerFailure(
      message:
          'Transaction reconciliation can only be performed by the server.',
    ));
  }

  @override
  Future<void> reStoreTransactionAfterFailure(
      {required double amount, required String userId}) async {
    throw UnsupportedError(
        'Wallet changes can only be performed by the server.');
  }

  @override
  Future<void> deducteFromTeacherWallet(
      {required double amount, required String userId}) async {
    throw UnsupportedError(
        'Wallet changes can only be performed by the server.');
  }

  @override
  Future<void> updateTransactionIsReconciled(
      {required String userId,
      required bool value,
      required String transactionId}) async {
    throw UnsupportedError(
        'Transaction reconciliation can only be performed by the server.');
  }

  @override
  Future<void> updateTransactionStatus(
      {required String userId,
      required String status,
      required String transactionId}) async {
    throw UnsupportedError(
        'Transaction statuses can only be changed by the server.');
  }
}
