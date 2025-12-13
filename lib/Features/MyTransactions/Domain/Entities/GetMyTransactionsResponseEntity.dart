import 'package:sintir/Core/entities/TransactionEntity.dart';

class GetMyTransactionsResponseEntity {
  final List<TransactionEntity> transactions;
  final bool hasMore;
  final bool isPaginate;
  GetMyTransactionsResponseEntity({
    required this.transactions,
    required this.hasMore,
    required this.isPaginate,
  });
}
