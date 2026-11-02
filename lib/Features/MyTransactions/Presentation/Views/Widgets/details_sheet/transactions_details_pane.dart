import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_panel.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_selection_placeholder.dart';

class TransactionsDetailsPane extends StatelessWidget {
  const TransactionsDetailsPane({
    super.key,
    required this.transaction,
    required this.onClose,
  });
  final TransactionEntity? transaction;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) => Expanded(
    flex: 5,
    child: Card(
      clipBehavior: Clip.antiAlias,
      child: transaction == null
          ? const TransactionSelectionPlaceholder()
          : TransactionDetailsPanel(
              transaction: transaction!,
              onClose: onClose,
            ),
    ),
  );
}
