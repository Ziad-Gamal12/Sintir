import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class TransactionSelectionPlaceholder extends StatelessWidget {
  const TransactionSelectionPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Icons.receipt_long_outlined,
          size: 42,
          color: Theme.of(context).colorScheme.primary,
        ),
        const SizedBox(height: 12),
        Text(LocaleKeys.transactionsSelectTransaction),
      ],
    ),
  );
}
