import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsEmptyState extends StatelessWidget {
  const TransactionsEmptyState({
    super.key,
    required this.hasTransactions,
    required this.hasFilters,
    required this.onClearFilters,
  });

  final bool hasTransactions;
  final bool hasFilters;
  final VoidCallback onClearFilters;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.receipt_long_outlined,
              size: 40,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 8),
            Text(
              hasTransactions
                  ? LocaleKeys.transactionsNoMatches
                  : LocaleKeys.transactionsNoData,
              style: AppTextStyles(context).semiBold14,
              textAlign: TextAlign.center,
            ),
            if (hasFilters)
              TextButton(
                onPressed: onClearFilters,
                child: Text(LocaleKeys.transactionsClearFilters),
              ),
          ],
        ),
      ),
    );
  }
}
