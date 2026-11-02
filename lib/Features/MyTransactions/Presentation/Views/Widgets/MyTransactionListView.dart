import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card.dart';

class MyTransactionSliverListView extends StatelessWidget {
  const MyTransactionSliverListView({super.key, required this.transactions});
  final List<TransactionEntity> transactions;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: transactions.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
          child: TransactionCard(
            key: ValueKey(transactions[index].transactionId),
            transaction: transactions[index],
          ),
        );
      },
    );
  }
}
