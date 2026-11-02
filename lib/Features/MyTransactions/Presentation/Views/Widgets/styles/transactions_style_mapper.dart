import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';

class TransactionsStyleMapper {
  const TransactionsStyleMapper._();

  static const brand = Color(0xFF2563EB);
  static const success = Color(0xFF059669);
  static const warning = Color(0xFFD97706);
  static const danger = Color(0xFFDC2626);
  static const neutral = Color(0xFF4B5563);

  static Color primary(ThemeData theme) =>
      theme.brightness == Brightness.dark ? const Color(0xFF3B82F6) : brand;

  static Color statusColor(ThemeData theme, TransactionsStatus? status) {
    final dark = theme.brightness == Brightness.dark;
    return switch (status) {
      TransactionsStatus.success => dark ? const Color(0xFF34D399) : success,
      TransactionsStatus.pending => dark ? const Color(0xFFFBBF24) : warning,
      TransactionsStatus.failure => dark ? const Color(0xFFF87171) : danger,
      _ => dark ? const Color(0xFF9CA3AF) : neutral,
    };
  }

  static Color statusSurface(ThemeData theme, TransactionsStatus? status) {
    final dark = theme.brightness == Brightness.dark;
    return switch (status) {
      TransactionsStatus.success =>
        dark
            ? const Color(0xFF064E3B).withValues(alpha: .4)
            : const Color(0xFFECFDF5),
      TransactionsStatus.pending =>
        dark
            ? const Color(0xFF78350F).withValues(alpha: .4)
            : const Color(0xFFFFFBEB),
      TransactionsStatus.failure =>
        dark
            ? const Color(0xFF7F1D1D).withValues(alpha: .4)
            : const Color(0xFFFEF2F2),
      _ =>
        dark
            ? const Color(0xFF374151).withValues(alpha: .4)
            : const Color(0xFFF3F4F6),
    };
  }

  static IconData statusIcon(TransactionsStatus? status) => switch (status) {
    TransactionsStatus.success => Icons.check_circle_outline_rounded,
    TransactionsStatus.pending => Icons.schedule_rounded,
    TransactionsStatus.failure => Icons.cancel_outlined,
    _ => Icons.info_outline_rounded,
  };

  static Color cardSurface(ThemeData theme) =>
      theme.brightness == Brightness.dark
      ? const Color(0xFF1E1E1E)
      : Colors.white;

  static Color cardBorder(ThemeData theme) =>
      theme.brightness == Brightness.dark
      ? const Color(0xFF2A2A2A)
      : const Color(0xFFF1F5F9);
}
