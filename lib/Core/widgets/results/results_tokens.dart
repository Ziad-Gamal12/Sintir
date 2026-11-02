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
    final dark = theme.brightness == Brightness.dark;
    return ResultsTokens._(
      page: dark ? const Color(0xFF0C1018) : const Color(0xFFF5F7FB),
      card: dark ? const Color(0xFF131A26) : const Color(0xFFFFFFFF),
      inner: dark ? const Color(0xFF1A2232) : const Color(0xFFF1F4FA),
      border: dark ? const Color(0x12FFFFFF) : const Color(0x0F000000),
      track: dark ? const Color(0x1AFFFFFF) : const Color(0x16000000),
      timelineNode: dark ? const Color(0x26FFFFFF) : const Color(0x24000000),
      muted: dark ? const Color(0xFFADB6C8) : const Color(0xFF5B6578),
      primary: dark ? const Color(0xFF9DB8FF) : theme.colorScheme.primary,
      success: dark ? const Color(0xFF55D98A) : const Color(0xFF137A4B),
      warning: dark ? const Color(0xFFFFB547) : const Color(0xFF8A4B08),
      failure: dark ? const Color(0xFFFF8B82) : const Color(0xFFB42318),
      shadow: dark ? const Color(0x00000000) : const Color(0x0F000000),
    );
  }

  BoxDecoration cardDecoration(ThemeData theme,
          {double radius = 20, Gradient? gradient}) =>
      BoxDecoration(
        color: card,
        gradient: gradient,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: border, width: 1),
        boxShadow: theme.brightness == Brightness.light
            ? [
                BoxShadow(
                    color: shadow, blurRadius: 16, offset: const Offset(0, 4))
              ]
            : const [],
      );
}
