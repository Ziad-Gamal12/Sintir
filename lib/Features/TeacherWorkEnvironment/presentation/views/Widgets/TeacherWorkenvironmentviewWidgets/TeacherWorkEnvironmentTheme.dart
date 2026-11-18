// ignore_for_file: file_names

import 'package:flutter/material.dart';

/// Color tokens for the teacher work environment and wallet screens.
///
/// Surfaces follow the app's own palette so these screens feel like the
/// rest of Sintir: in dark mode cards sit on the app scaffold (#121212) as
/// #1E1E1E surfaces with a 10% white hairline, like the profile groups,
/// course cards and search field elsewhere. Only accents (primary tints,
/// status colors) are specific to this feature. `test/.../theme_parity_test`
/// guards the shared values against drift from `AppTheme`.
@immutable
class WorkEnvironmentThemeExtension
    extends ThemeExtension<WorkEnvironmentThemeExtension> {
  const WorkEnvironmentThemeExtension({
    required this.cardBackground,
    required this.cardBorder,
    required this.cardShadow,
    required this.mutedText,
    required this.primaryTint,
    required this.primaryBorder,
    required this.secondaryButtonFill,
    required this.successForeground,
    required this.successBackground,
    required this.successBorder,
    required this.warningForeground,
    required this.warningBackground,
    required this.warningBorder,
    required this.dangerForeground,
    required this.dangerBackground,
    required this.dangerBorder,
    required this.neutralForeground,
    required this.neutralBackground,
    required this.neutralBorder,
    required this.searchFill,
    required this.searchBorder,
  });

  final Color cardBackground;
  final Color cardBorder;
  final Color cardShadow;
  final Color mutedText;
  final Color primaryTint;
  final Color primaryBorder;

  /// Fill of tonal secondary actions such as "Add course".
  final Color secondaryButtonFill;
  final Color successForeground;
  final Color successBackground;
  final Color successBorder;
  final Color warningForeground;
  final Color warningBackground;
  final Color warningBorder;

  /// Blocking states, e.g. an inactive wallet.
  final Color dangerForeground;
  final Color dangerBackground;
  final Color dangerBorder;
  final Color neutralForeground;
  final Color neutralBackground;
  final Color neutralBorder;
  final Color searchFill;
  final Color searchBorder;

  static const WorkEnvironmentThemeExtension dark =
      WorkEnvironmentThemeExtension(
        // = AppTheme.dark cardColor / colorScheme.surface
        cardBackground: Color(0xFF1E1E1E),
        // Same hairline as the app's cards and search field (white 10%).
        cardBorder: Color(0x1AFFFFFF),
        cardShadow: Color(0x00000000),
        // Neutral grey: readable on #1E1E1E (≈6.6:1) without a blue cast.
        mutedText: Color(0xFFA3A3A3),
        primaryTint: Color(0x264169E2), // ~15%
        primaryBorder: Color(0x594169E2), // ~35%
        secondaryButtonFill: Color(0xFF1E1E1E),
        successForeground: Color(0xFF22C55E),
        successBackground: Color(0x1A22C55E), // ~10%
        successBorder: Color(0x5222C55E), // ~32%
        warningForeground: Color(0xFFFBBF24),
        warningBackground: Color(0x24F59E0B),
        warningBorder: Color(0x52F59E0B),
        dangerForeground: Color(0xFFF87171),
        dangerBackground: Color(0x1AEF4444), // ~10%
        dangerBorder: Color(0x52EF4444), // ~32%
        neutralForeground: Color(0xFFA3A3A3),
        neutralBackground: Color(0x24A3A3A3),
        neutralBorder: Color(0x52A3A3A3),
        searchFill: Color(0xFF1E1E1E),
        searchBorder: Color(0x1AFFFFFF),
      );

  static const WorkEnvironmentThemeExtension light =
      WorkEnvironmentThemeExtension(
        cardBackground: Color(0xFFFFFFFF),
        cardBorder: Color(0xFFE5E8F0),
        cardShadow: Color(0x0A000000),
        mutedText: Color(0xFF64748B),
        primaryTint: Color(0x1A4169E2), // ~10%
        primaryBorder: Color(0x594169E2), // ~35%
        secondaryButtonFill: Color(0x1A4169E2), // ~10%
        successForeground: Color(0xFF15803D),
        successBackground: Color(0x1F15803D), // ~12%
        successBorder: Color(0x4D15803D), // ~30%
        warningForeground: Color(0xFFB45309),
        warningBackground: Color(0x1FB45309), // ~12%
        warningBorder: Color(0x4DB45309), // ~30%
        dangerForeground: Color(0xFFB91C1C),
        dangerBackground: Color(0x1AB91C1C), // ~10%
        dangerBorder: Color(0x4DB91C1C), // ~30%
        neutralForeground: Color(0xFF4B5563),
        neutralBackground: Color(0x1A4B5563), // ~10%
        neutralBorder: Color(0x404B5563), // ~25%
        searchFill: Color(0xFFFFFFFF),
        searchBorder: Color(0xFFE5E8F0),
      );

  static WorkEnvironmentThemeExtension of(BuildContext context) {
    final ext = Theme.of(context).extension<WorkEnvironmentThemeExtension>();
    if (ext != null) return ext;
    return Theme.of(context).brightness == Brightness.dark ? dark : light;
  }

  @override
  WorkEnvironmentThemeExtension copyWith({
    Color? cardBackground,
    Color? cardBorder,
    Color? cardShadow,
    Color? mutedText,
    Color? primaryTint,
    Color? primaryBorder,
    Color? secondaryButtonFill,
    Color? successForeground,
    Color? successBackground,
    Color? successBorder,
    Color? warningForeground,
    Color? warningBackground,
    Color? warningBorder,
    Color? dangerForeground,
    Color? dangerBackground,
    Color? dangerBorder,
    Color? neutralForeground,
    Color? neutralBackground,
    Color? neutralBorder,
    Color? searchFill,
    Color? searchBorder,
  }) {
    return WorkEnvironmentThemeExtension(
      cardBackground: cardBackground ?? this.cardBackground,
      cardBorder: cardBorder ?? this.cardBorder,
      cardShadow: cardShadow ?? this.cardShadow,
      mutedText: mutedText ?? this.mutedText,
      primaryTint: primaryTint ?? this.primaryTint,
      primaryBorder: primaryBorder ?? this.primaryBorder,
      secondaryButtonFill: secondaryButtonFill ?? this.secondaryButtonFill,
      successForeground: successForeground ?? this.successForeground,
      successBackground: successBackground ?? this.successBackground,
      successBorder: successBorder ?? this.successBorder,
      warningForeground: warningForeground ?? this.warningForeground,
      warningBackground: warningBackground ?? this.warningBackground,
      warningBorder: warningBorder ?? this.warningBorder,
      dangerForeground: dangerForeground ?? this.dangerForeground,
      dangerBackground: dangerBackground ?? this.dangerBackground,
      dangerBorder: dangerBorder ?? this.dangerBorder,
      neutralForeground: neutralForeground ?? this.neutralForeground,
      neutralBackground: neutralBackground ?? this.neutralBackground,
      neutralBorder: neutralBorder ?? this.neutralBorder,
      searchFill: searchFill ?? this.searchFill,
      searchBorder: searchBorder ?? this.searchBorder,
    );
  }

  @override
  WorkEnvironmentThemeExtension lerp(
    covariant ThemeExtension<WorkEnvironmentThemeExtension>? other,
    double t,
  ) {
    if (other is! WorkEnvironmentThemeExtension) return this;
    Color mix(Color a, Color b) => Color.lerp(a, b, t) ?? a;
    return WorkEnvironmentThemeExtension(
      cardBackground: mix(cardBackground, other.cardBackground),
      cardBorder: mix(cardBorder, other.cardBorder),
      cardShadow: mix(cardShadow, other.cardShadow),
      mutedText: mix(mutedText, other.mutedText),
      primaryTint: mix(primaryTint, other.primaryTint),
      primaryBorder: mix(primaryBorder, other.primaryBorder),
      secondaryButtonFill: mix(secondaryButtonFill, other.secondaryButtonFill),
      successForeground: mix(successForeground, other.successForeground),
      successBackground: mix(successBackground, other.successBackground),
      successBorder: mix(successBorder, other.successBorder),
      warningForeground: mix(warningForeground, other.warningForeground),
      warningBackground: mix(warningBackground, other.warningBackground),
      warningBorder: mix(warningBorder, other.warningBorder),
      dangerForeground: mix(dangerForeground, other.dangerForeground),
      dangerBackground: mix(dangerBackground, other.dangerBackground),
      dangerBorder: mix(dangerBorder, other.dangerBorder),
      neutralForeground: mix(neutralForeground, other.neutralForeground),
      neutralBackground: mix(neutralBackground, other.neutralBackground),
      neutralBorder: mix(neutralBorder, other.neutralBorder),
      searchFill: mix(searchFill, other.searchFill),
      searchBorder: mix(searchBorder, other.searchBorder),
    );
  }
}
