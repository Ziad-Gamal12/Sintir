import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/MyTransactions/Domain/Entities/GetMyTransactionsResponseEntity.dart';

abstract class MyTransactionsRepo {
  Future<Either<Failure, GetMyTransactionsResponseEntity>> getMyTransactions(
      {required String userId, required bool isPaginate});
}
