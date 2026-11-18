import 'package:flutter/material.dart';

/// Palette and surface treatment for the My Results screen.
class ResultsTokens {
  const ResultsTokens._({
    required this.page,
    required this.card,
    required this.inner,
    required this.border,
    required this.track,
    required this.timelineNode,
    required this.muted,
    required this.primary,
    required this.success,
    required this.warning,
    required this.failure,
    required this.shadow,
  });

  final Color page, card, inner, border, track, timelineNode, muted, primary;
  final Color success, warning, failure, shadow;

  static ResultsTokens of(ThemeData theme) {
    final scheme = theme.colorScheme;
    final dark = theme.brightness == Brightness.dark;
    Color tint(double a) =>
        Color.alphaBlend(scheme.onSurface.withValues(alpha: a), scheme.surface);

    return ResultsTokens._(
      page: theme.scaffoldBackgroundColor,
      card: tint(0.04),
      inner: tint(0.07),
      border: scheme.onSurface.withValues(alpha: 0.10),
      track: scheme.onSurface.withValues(alpha: 0.10),
      timelineNode: scheme.onSurface.withValues(alpha: 0.20),
      muted: scheme.onSurface.withValues(alpha: 0.70),
      primary: dark ? const Color(0xFF9DB8FF) : scheme.primary,
      success: dark ? const Color(0xFF55D98A) : const Color(0xFF137A4B),
      warning: dark ? const Color(0xFFFFB547) : const Color(0xFF8A4B08),
      failure: dark ? const Color(0xFFFF8B82) : const Color(0xFFB42318),
      shadow: dark ? const Color(0x00000000) : const Color(0x0F000000),
    );
  }

  BoxDecoration cardDecoration(
    ThemeData theme, {
    double radius = 20,
    Gradient? gradient,
  }) => BoxDecoration(
    color: card,
    gradient: gradient,
    borderRadius: BorderRadius.circular(radius),
    border: Border.all(color: border, width: 1),
    boxShadow: theme.brightness == Brightness.light
        ? [BoxShadow(color: shadow, blurRadius: 16, offset: const Offset(0, 4))]
        : const [],
  );
}
