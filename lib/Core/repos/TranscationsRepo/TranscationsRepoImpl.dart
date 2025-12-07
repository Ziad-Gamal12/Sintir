import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/TranscationsRepo/TranscationsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/data/Models/TransactionModel.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TransactionEntity.dart';
import 'package:sintir/locale_keys.dart';

class TranscationsRepoImpl implements TranscationsRepo {
  final DataBaseService dataBaseService;
  TranscationsRepoImpl({required this.dataBaseService});

  @override
  Future<Either<Failure, void>> storeTransaction(
      {required TransactionEntity transaction, required String userId}) async {
    try {
      Map<String, dynamic> transactionJson =
          TransactionModel.fromEntity(transaction).toJson();
      await dataBaseService.setData(
          data: transactionJson,
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.usersCollectionName,
              docId: userId,
              subCollection: BackendEndpoints.transactionsSubCollection,
              subDocId: transaction.transactionId));
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> reconcileTransaction(
      {required TransactionEntity transaction,
      required String userId,
      required String newStatus}) async {
    try {
      await updateTransactionStatus(
          userId: userId,
          status: newStatus,
          transactionId: transaction.transactionId ?? "");
      if (newStatus.toUpperCase() == "REJECTED" ||
          newStatus.toUpperCase() == "CANCELLED" ||
          newStatus.toUpperCase() == "FAILED") {
        if (transaction.isReconciled == false) {
          await reStoreTransactionAfterFailure(
              amount: transaction.amount ?? 0, userId: userId);
          await updateTransactionIsReconciled(
              userId: userId,
              value: true,
              transactionId: transaction.transactionId ?? "");
        }
        return right(null);
      } else if (newStatus.toUpperCase() == "COMPLETED" ||
          newStatus.toUpperCase() == "APPROVED" ||
          newStatus.toUpperCase() == "SUCCESS") {
        if (transaction.isReconciled == true) {
          await updateTransactionIsReconciled(
              userId: userId,
              value: false,
              transactionId: transaction.transactionId ?? "");
          await deducteFromTeacherWallet(
            amount: transaction.amount ?? 0,
            userId: userId,
          );
        }
        return right(null);
      } else {
        return right(null);
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<void> reStoreTransactionAfterFailure(
      {required double amount, required String userId}) async {
    await dataBaseService.updateData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userId,
        ),
        field: "teacherExtraData.wallet.balance",
        data: FieldValue.increment(amount));
  }

  @override
  Future<void> deducteFromTeacherWallet(
      {required double amount, required String userId}) async {
    await dataBaseService.updateData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userId,
        ),
        field: "teacherExtraData.wallet.balance",
        data: FieldValue.increment(-amount));
  }

  @override
  Future<void> updateTransactionIsReconciled(
      {required String userId,
      required bool value,
      required String transactionId}) async {
    await dataBaseService.updateData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userId,
        subCollection: BackendEndpoints.transactionsSubCollection,
        subDocId: transactionId,
      ),
      field: "isReconciled",
      data: value,
    );
  }

  @override
  Future<void> updateTransactionStatus(
      {required String userId,
      required String status,
      required String transactionId}) async {
    await dataBaseService.updateData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userId,
        subCollection: BackendEndpoints.transactionsSubCollection,
        subDocId: transactionId,
      ),
      field: "status",
      data: status,
    );
  }
}
