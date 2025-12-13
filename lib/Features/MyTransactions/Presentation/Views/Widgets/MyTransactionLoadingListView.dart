import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/MyTransactionListViewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyTransactionLoadingListView extends StatelessWidget {
  const MyTransactionLoadingListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: TransactionEntity.getFakeTransactions().length,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              child: AspectRatio(
                aspectRatio: 2 / 1,
                child: Skeletonizer(
                  enabled: true,
                  child: MyTransactionListViewItem(
                      transactionEntity:
                          TransactionEntity.getFakeTransactions()[index]),
                ),
              ));
        });
  }
}
