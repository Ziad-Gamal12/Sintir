import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/locale_keys.dart';

class TransactionMethodMapper {
  const TransactionMethodMapper._();

  static String key(String method) {
    final value = method.toLowerCase().trim();
    if (value.contains('card') ||
        value.contains('credit') ||
        value == 'payment' ||
        value.contains('بطاقة')) {
      return 'card';
    }
    if (value.contains('wallet') ||
        value.contains('vodafone') ||
        value.contains('mobile') ||
        value.contains('محفظ')) {
      return 'wallet';
    }
    if (value.contains('fawry') ||
        value.contains('outlet') ||
        value.contains('فوري')) {
      return 'fawry';
    }
    if (value.contains('cash') || value.contains('نقد')) return 'cash';
    if (value.contains('transfer') ||
        value.contains('instapay') ||
        value.contains('ach') ||
        value.contains('تحويل')) {
      return 'transfer';
    }
    return 'other';
  }

  static String label(String method) => switch (key(method)) {
    'card' => LocaleKeys.transactionsBankCard,
    'wallet' => LocaleKeys.transactionsWallet,
    'fawry' => LocaleKeys.transactionsFawry,
    'cash' => LocaleKeys.transactionsCash,
    'transfer' => LocaleKeys.transactionsDirectTransfer,
    _ => method,
  };

  static String detailLabel(String method) => key(method) == 'card'
      ? LocaleKeys.transactionsBankCardDetail
      : label(method);

  static IconData icon(String method, {TransactionsStatus? status}) {
    if (status == TransactionsStatus.failure && key(method) == 'card') {
      return Icons.credit_card_off_rounded;
    }
    return switch (key(method)) {
      'card' => Icons.credit_card_rounded,
      'wallet' => Icons.account_balance_wallet_rounded,
      'fawry' => Icons.storefront_rounded,
      'cash' => Icons.payments_rounded,
      'transfer' => Icons.swap_horiz_rounded,
      _ => Icons.receipt_long_rounded,
    };
  }

  static Color color(
    ThemeData theme,
    String method,
    TransactionsStatus? status,
  ) {
    final dark = theme.brightness == Brightness.dark;
    if (status == TransactionsStatus.failure && key(method) == 'card') {
      return dark ? const Color(0xFFF87171) : TransactionsStyleMapper.danger;
    }
    return switch (key(method)) {
      'card' => dark ? const Color(0xFF3B82F6) : TransactionsStyleMapper.brand,
      'wallet' => dark ? const Color(0xFFFB923C) : const Color(0xFFEA580C),
      'fawry' => dark ? const Color(0xFF34D399) : const Color(0xFF10B981),
      'cash' => dark ? const Color(0xFF2DD4BF) : const Color(0xFF0D9488),
      'transfer' => dark ? const Color(0xFFA5B4FC) : const Color(0xFF6366F1),
      _ => dark ? const Color(0xFF9CA3AF) : TransactionsStyleMapper.neutral,
    };
  }
}
