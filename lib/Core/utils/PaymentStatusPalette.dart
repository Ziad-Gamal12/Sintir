import 'package:flutter/material.dart';

/// Semantic colors shared by the checkout recovery and confirmed success UIs.
class PaymentStatusPalette {
  const PaymentStatusPalette._();

  static PaymentStatusColors forTheme(ThemeData theme) {
    final dark = theme.brightness == Brightness.dark;
    return PaymentStatusColors(
      pending: dark ? const Color(0xFFFFD28A) : const Color(0xFF8A4B08),
      pendingSurface: dark ? const Color(0xFF392A14) : const Color(0xFFFFF3DC),
      information: dark ? const Color(0xFF9DB8FF) : const Color(0xFF3158B7),
      informationSurface:
          dark ? const Color(0xFF202D49) : const Color(0xFFEDF2FF),
      success: dark ? const Color(0xFF8FE0B0) : const Color(0xFF137A4B),
      successSurface: dark ? const Color(0xFF153326) : const Color(0xFFE8F5EC),
      failure: dark ? const Color(0xFFFFB4AB) : const Color(0xFFB42318),
      failureSurface: dark ? const Color(0xFF3A1D1B) : const Color(0xFFFFEEEC),
    );
  }
}

class PaymentStatusColors {
  const PaymentStatusColors({
    required this.pending,
    required this.pendingSurface,
    required this.information,
    required this.informationSurface,
    required this.success,
    required this.successSurface,
    required this.failure,
    required this.failureSurface,
  });

  final Color pending;
  final Color pendingSurface;
  final Color information;
  final Color informationSurface;
  final Color success;
  final Color successSurface;
  final Color failure;
  final Color failureSurface;
}
