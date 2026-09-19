import 'package:flutter/material.dart';

class TransactionDetailsSheetHandle extends StatelessWidget {
  const TransactionDetailsSheetHandle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: 40,
      height: 4,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: theme.dividerTheme.color,
        borderRadius: BorderRadius.circular(4),
      ),
    );
  }
}
