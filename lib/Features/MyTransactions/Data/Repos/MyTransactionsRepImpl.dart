import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/TransactionModel.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/MyTransactions/Domain/Entities/GetMyTransactionsResponseEntity.dart';
import 'package:sintir/Features/MyTransactions/Domain/Repos/MyTransactionsRep.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class MyTransactionsRepoImpl implements MyTransactionsRepo {
  final DataBaseService dataBaseService;
  MyTransactionsRepoImpl({required this.dataBaseService});
  DocumentSnapshot? getMyTransactionsLastDoc;

  @override
  Future<Either<Failure, GetMyTransactionsResponseEntity>> getMyTransactions({
    required String userId,
    required bool isPaginate,
  }) async {
    try {
      if (!isPaginate) getMyTransactionsLastDoc = null;
      Map<String, dynamic> query = {
        "limit": 10,
        "orderBy": "created_at",
        "startAfter": isPaginate == true ? getMyTransactionsLastDoc : null,
        "filters": [
          {
            "field": "method",
            "operator": "==",
            "value": BackendEndpoints.payMentMethod,
          },
        ],
      };

      final response = await dataBaseService.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.usersCollectionName,
          docId: userId,
          subCollection: BackendEndpoints.transactionsSubCollection,
        ),
        query: query,
      );
      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      if (response.listData!.isEmpty) {
        return right(
          GetMyTransactionsResponseEntity(
            transactions: [],
            hasMore: false,
            isPaginate: isPaginate,
          ),
        );
      }
      if (response.lastDocumentSnapshot != null) {
        getMyTransactionsLastDoc = response.lastDocumentSnapshot;
      }

      return right(
        GetMyTransactionsResponseEntity(
          transactions: response.listData!.map((e) {
            final model = TransactionModel.fromJson(e);
            return model.toEntity().copyWith(
              status: _myTransactionsStatus(model.status),
            );
          }).toList(),
          hasMore: response.hasMore ?? false,
          isPaginate: isPaginate,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  TransactionsStatus _myTransactionsStatus(String? raw) {
    switch (raw?.trim().toUpperCase()) {
      case 'SUCCESS':
      case 'SUCCESSFUL':
      case 'COMPLETED':
      case 'APPROVED':
        return TransactionsStatus.success;
      case 'FAILED':
      case 'FAILURE':
      case 'REJECTED':
      case 'CANCELLED':
        return TransactionsStatus.failure;
      case 'RESERVED':
      case 'PENDING':
      case 'PROCESSING_UNKNOWN':
      case 'IN_PROGRESS':
        return TransactionsStatus.pending;
      default:
        return TransactionsStatus.other;
    }
  }
}
