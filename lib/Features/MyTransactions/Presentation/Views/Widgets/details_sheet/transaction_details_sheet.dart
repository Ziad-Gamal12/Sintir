import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_panel.dart';

Future<void> showTransactionDetails(
  BuildContext context,
  TransactionEntity transaction,
) async {
  final width = MediaQuery.sizeOf(context).width;
  if (width >= 900) {
    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: SizedBox(
          width: 680,
          height: 720,
          child: TransactionDetailsPanel(
            transaction: transaction,
            onClose: () => Navigator.pop(context),
          ),
        ),
      ),
    );
    return;
  }
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (context) => SizedBox(
      height: MediaQuery.sizeOf(context).height * .9,
      child: TransactionDetailsPanel(
        transaction: transaction,
        showHandle: true,
        onClose: () => Navigator.pop(context),
      ),
    ),
  );
}
