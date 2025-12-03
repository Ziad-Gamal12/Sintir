import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TransactionEntity.dart';

abstract class TranscationsRepo {
  Future<Either<Failure, void>> storeTransaction(
      {required TransactionEntity transaction, required String userId});

  Future<Either<Failure, void>> reconcileTransactionStatus(
      {required String transactionId,
      required String userId,
      required String newStatus});
}
