import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/list/transaction_day_group_header.dart';

class TransactionsListItem extends StatelessWidget {
  const TransactionsListItem({
    super.key,
    required this.item,
    this.onTransactionSelected,
  });

  final TransactionListItem item;
  final ValueChanged<TransactionEntity>? onTransactionSelected;

  @override
  Widget build(BuildContext context) {
    final group = item.group;
    if (group != null) return TransactionDayGroupHeader(group: group);
    final transaction = item.transaction!;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(16, 6, 16, 6),
      child: TransactionCard(
        key: ValueKey(transaction.transactionId),
        transaction: transaction,
        onSelected: onTransactionSelected == null
            ? null
            : () => onTransactionSelected!(transaction),
      ),
    );
  }
}
