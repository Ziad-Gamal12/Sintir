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
  Future<Either<Failure, void>> reconcileTransactionStatus(
      {required String transactionId,
      required String userId,
      required String newStatus}) async {
    try {
      await dataBaseService.updateData(
        collectionKey: BackendEndpoints.usersCollectionName,
        field: "status",
        doc: userId,
        subCollectionKey: BackendEndpoints.transactionsSubCollection,
        subDocId: transactionId,
        data: newStatus,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}
