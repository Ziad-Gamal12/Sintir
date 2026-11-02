import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/PaymentStatusPalette.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';

class TransactionsStyleMapper {
  const TransactionsStyleMapper._();

  static Color statusColor(ThemeData theme, TransactionsStatus? status) {
    final colors = PaymentStatusPalette.forTheme(theme);
    return switch (status) {
      TransactionsStatus.success => colors.success,
      TransactionsStatus.pending => colors.pending,
      TransactionsStatus.failure => colors.failure,
      _ => colors.information,
    };
  }

  static Color statusSurface(ThemeData theme, TransactionsStatus? status) {
    final colors = PaymentStatusPalette.forTheme(theme);
    return switch (status) {
      TransactionsStatus.success => colors.successSurface,
      TransactionsStatus.pending => colors.pendingSurface,
      TransactionsStatus.failure => colors.failureSurface,
      _ => colors.informationSurface,
    };
  }

  static IconData statusIcon(TransactionsStatus? status) => switch (status) {
        TransactionsStatus.success => Icons.check_circle_outline,
        TransactionsStatus.pending => Icons.schedule_rounded,
        TransactionsStatus.failure => Icons.cancel_outlined,
        _ => Icons.info_outline_rounded,
      };

  static IconData methodIcon(String method, {TransactionsStatus? status}) {
    final value = method.toLowerCase();
    if ((value.contains('card') || value.contains('بطاقة')) &&
        status == TransactionsStatus.failure) {
      return Icons.credit_card_off;
    }
    if (value.contains('card') || value.contains('بطاقة')) {
      return Icons.credit_card_rounded;
    }
    if (value.contains('wallet') ||
        value.contains('mobile') ||
        value.contains('محفظ')) {
      return Icons.account_balance_wallet_outlined;
    }
    if (value.contains('fawry') ||
        value.contains('outlet') ||
        value.contains('فوري')) {
      return Icons.storefront_outlined;
    }
    if (value.contains('cash') || value.contains('نقد')) {
      return Icons.payments_outlined;
    }
    if (value.contains('transfer') ||
        value.contains('instapay') ||
        value.contains('تحويل')) {
      return Icons.swap_horiz_rounded;
    }
    return Icons.receipt_long_outlined;
  }

  static Color methodColor(
      ThemeData theme, String method, TransactionsStatus? status) {
    final colors = PaymentStatusPalette.forTheme(theme);
    final value = method.toLowerCase();
    if (status == TransactionsStatus.failure &&
        (value.contains('card') || value.contains('بطاقة'))) {
      return colors.failure;
    }
    if (value.contains('wallet') ||
        value.contains('mobile') ||
        value.contains('محفظ')) {
      return colors.pending;
    }
    if (value.contains('fawry') ||
        value.contains('outlet') ||
        value.contains('فوري')) {
      return colors.success;
    }
    if (value.contains('cash') || value.contains('نقد')) {
      return theme.brightness == Brightness.dark
          ? const Color(0xFF8DD9CF)
          : const Color(0xFF087F73);
    }
    if (value.contains('transfer') ||
        value.contains('instapay') ||
        value.contains('تحويل')) {
      return colors.information;
    }
    return theme.colorScheme.primary;
  }

  static String maskPhone(String value) {
    if (value.contains('*')) {
      return value;
    }
    final digits = value.replaceAll(RegExp(r'\D'), '');
    if (digits.length <= 4) {
      return value;
    }
    final prefixLength = digits.length > 10 ? digits.length - 10 + 4 : 4;
    final prefix =
        digits.substring(0, prefixLength.clamp(1, digits.length - 4));
    return '+$prefix *** ${digits.substring(digits.length - 4)}';
  }
}
