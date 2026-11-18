import 'package:flutter/material.dart';

/// Centralized semantic color tokens for student exam results.
/// Provides refined, muted, accessible tonal palettes for Dark and Light modes.
class ResultSemanticColors {
  const ResultSemanticColors({
    required this.foreground,
    required this.background,
    required this.border,
  });

  final Color foreground;
  final Color background;
  final Color border;

  /// Success state: Muted Emerald (#34D399 in dark / #059669 in light)
  static ResultSemanticColors success(bool isDark) {
    if (isDark) {
      return ResultSemanticColors(
        foreground: const Color(0xFF34D399),
        background: const Color(0xFF34D399).withValues(alpha: 0.12),
        border: const Color(0xFF34D399).withValues(alpha: 0.22),
      );
    }
    return ResultSemanticColors(
      foreground: const Color(0xFF059669),
      background: const Color(0xFF059669).withValues(alpha: 0.08),
      border: const Color(0xFF059669).withValues(alpha: 0.18),
    );
  }

  /// Failure state: Muted Rose / Coral (#FB7185 in dark / #E11D48 in light)
  static ResultSemanticColors failure(bool isDark) {
    if (isDark) {
      return ResultSemanticColors(
        foreground: const Color(0xFFFB7185),
        background: const Color(0xFFFB7185).withValues(alpha: 0.12),
        border: const Color(0xFFFB7185).withValues(alpha: 0.22),
      );
    }
    return ResultSemanticColors(
      foreground: const Color(0xFFE11D48),
      background: const Color(0xFFE11D48).withValues(alpha: 0.08),
      border: const Color(0xFFE11D48).withValues(alpha: 0.18),
    );
  }

  /// Unavailable state: Slate Gray (#94A3B8 in dark / #64748B in light)
  static ResultSemanticColors unavailable(bool isDark) {
    if (isDark) {
      return ResultSemanticColors(
        foreground: const Color(0xFF94A3B8),
        background: const Color(0xFF94A3B8).withValues(alpha: 0.10),
        border: const Color(0xFF94A3B8).withValues(alpha: 0.18),
      );
    }
    return ResultSemanticColors(
      foreground: const Color(0xFF64748B),
      background: const Color(0xFF64748B).withValues(alpha: 0.08),
      border: const Color(0xFF64748B).withValues(alpha: 0.16),
    );
  }

  /// Resolves the semantic color tokens according to theme and exam status.
  static ResultSemanticColors resolve({
    required bool isDark,
    required bool hasValidQuestions,
    required bool isPassed,
  }) {
    if (!hasValidQuestions) {
      return unavailable(isDark);
    }
    return isPassed ? success(isDark) : failure(isDark);
  }
}
