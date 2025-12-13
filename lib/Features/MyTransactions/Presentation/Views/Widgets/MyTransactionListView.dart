import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/MyTransactionListViewItem.dart';

class MyTransactionSliverListView extends StatelessWidget {
  const MyTransactionSliverListView({super.key, required this.transactions});
  final List<TransactionEntity> transactions;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: MyTransactionListViewItem(
                    transactionEntity: transactions[index]),
              ));
        });
  }
}
