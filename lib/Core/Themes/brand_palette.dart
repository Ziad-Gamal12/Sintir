import 'package:flutter/material.dart';

@immutable
class BrandPalette {
  const BrandPalette._({
    required this.page,
    required this.textMuted,
    required this.placeholder,
    required this.outline,
    required this.link,
    required this.accent,
    required this.brandPanel,
    required this.brandStage,
    required this.onBrand,
    required this.onBrandMuted,
    required this.chipBackground,
    required this.chipForeground,
    required this.dotInactive,
  });

  final Color page;
  final Color textMuted;
  final Color placeholder;
  final Color outline;
  final Color link;
  final Color accent;
  final Color brandPanel;
  final Color brandStage;
  final Color onBrand;
  final Color onBrandMuted;
  final Color chipBackground;
  final Color chipForeground;
  final Color dotInactive;

  static const BrandPalette dark = BrandPalette._(
    page: Color(0xFF121212),
    textMuted: Color(0xFFA9AFBB),
    placeholder: Color(0xFF8C929E),
    outline: Color(0xFF666B79),
    link: Color(0xFF8AA4FF),
    accent: Color(0xFFFF8C1A),
    brandPanel: Color(0xFF1F2A4C),
    brandStage: Color(0xFF283766),
    onBrand: Color(0xFFFFFFFF),
    onBrandMuted: Color(0xFFB9C3DD),
    chipBackground: Color(0xFF1A2238),
    chipForeground: Color(0xFF9DB3FF),
    dotInactive: Color(0xFF3A4257),
  );

  static const BrandPalette light = BrandPalette._(
    page: Color(0xFFF5F7FB),
    textMuted: Color(0xFF545D6E),
    placeholder: Color(0xFF6B7383),
    outline: Color(0xFF858B9B),
    link: Color(0xFF3157D5),
    accent: Color(0xFFA85200),
    brandPanel: Color(0xFFE7EDFD),
    brandStage: Color(0xFFD5DFFB),
    onBrand: Color(0xFF111827),
    onBrandMuted: Color(0xFF465067),
    chipBackground: Color(0xFFE4EBFD),
    chipForeground: Color(0xFF2F52C9),
    dotInactive: Color(0xFFC3CCE6),
  );

  static BrandPalette of(BuildContext context) =>
      Theme.of(context).brightness == Brightness.dark ? dark : light;
}
