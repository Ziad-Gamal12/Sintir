// my_transaction_list_item.dart

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Domain/helpers/transaction_helpers.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/TransactionCardFooter.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/TransactionCardHeader.dart';

class MyTransactionListViewItem extends StatelessWidget {
  const MyTransactionListViewItem({super.key, required this.transactionEntity});

  final TransactionEntity transactionEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Get the status color just for the accent line
    final statusColor = getStatusColor(context, transactionEntity.status);

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(
          color: theme.dividerColor.withOpacity(0.2),
          width: 0.5,
        ),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.04),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: IntrinsicHeight(
        child: Row(
          children: [
            // --- ACCENT LINE ---
            Container(
              width: 5.0,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(16.0),
                  bottomLeft: Radius.circular(16.0),
                ),
              ),
            ),

            // --- CARD CONTENT (Composition) ---
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TransactionCardHeader(transactionEntity: transactionEntity),
                    const SizedBox(height: 16),
                    TransactionCardFooter(transactionEntity: transactionEntity),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
