import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_actions.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_header.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_hero.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_rows.dart';

class TransactionDetailsPanel extends StatelessWidget {
  const TransactionDetailsPanel({
    super.key,
    required this.transaction,
    this.onClose,
    this.showHandle = false,
  });
  final TransactionEntity transaction;
  final VoidCallback? onClose;
  final bool showHandle;

  @override
  Widget build(BuildContext context) => Material(
    color: Theme.of(context).colorScheme.surface,
    borderRadius: BorderRadius.circular(20),
    child: Column(
      children: [
        if (showHandle)
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 5,
            decoration: BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.primary.withValues(alpha: .2),
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        if (onClose != null)
          TransactionDetailsHeader(transaction: transaction, onClose: onClose!),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                TransactionDetailsHero(transaction: transaction),
                const SizedBox(height: 14),
                TransactionDetailsRows(transaction: transaction),
                const SizedBox(height: 14),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: TransactionDetailsActions(transaction: transaction),
        ),
      ],
    ),
  );
}
