// transaction_helpers.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// --- Logic/Utility Functions ---

Color getStatusColor(BuildContext context, String? status) {
  if (status == null) return Theme.of(context).colorScheme.tertiary;

  final lowerStatus = status.toLowerCase();
  if (lowerStatus.contains('success') || lowerStatus.contains('paid')) {
    return Colors.green.shade400;
  } else if (lowerStatus.contains('pending')) {
    return Colors.amber.shade600;
  } else if (lowerStatus.contains('failed') ||
      lowerStatus.contains('rejected')) {
    return Colors.red.shade400;
  }
  return Theme.of(context).colorScheme.secondary;
}

IconData getMethodIcon(String? method) {
  final lowerMethod = method?.toLowerCase();
  if (lowerMethod == null) return Icons.receipt_long;

  if (lowerMethod.contains('card')) return Icons.credit_card_rounded;
  if (lowerMethod.contains('mobile')) return Icons.smartphone_rounded;
  if (lowerMethod.contains('bank')) return Icons.account_balance_rounded;

  return Icons.payments_rounded;
}

String formatAmount(double? amount, String? currency) {
  if (amount == null) return '--';

  final numberFormat = NumberFormat.currency(
    locale: 'en_US',
    symbol: currency ?? '\$',
    decimalDigits: amount % 1 == 0 ? 0 : 2,
  );
  return numberFormat.format(amount);
}
