import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/Themes/app_theme.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';

/// WCAG contrast ratio between two opaque colors.
double _contrast(Color a, Color b) {
  final la = a.computeLuminance();
  final lb = b.computeLuminance();
  return (math.max(la, lb) + 0.05) / (math.min(la, lb) + 0.05);
}

/// The work environment and wallet screens must look like the rest of the
/// app: same surfaces, same hairline, readable secondary text.
void main() {
  for (final (name, theme, tokens) in [
    ('dark', AppTheme.dark, WorkEnvironmentThemeExtension.dark),
    ('light', AppTheme.light, WorkEnvironmentThemeExtension.light),
  ]) {
    group('$name theme', () {
      test('registers the matching token set', () {
        expect(theme.extension<WorkEnvironmentThemeExtension>(), tokens);
      });

      test('cards and search use the app card surface', () {
        expect(tokens.cardBackground, theme.cardColor);
        expect(tokens.searchFill, theme.cardColor);
      });

      test('muted text is readable on cards and on the page (AA)', () {
        expect(
          _contrast(tokens.mutedText, tokens.cardBackground),
          greaterThanOrEqualTo(4.5),
        );
        expect(
          _contrast(tokens.mutedText, theme.scaffoldBackgroundColor),
          greaterThanOrEqualTo(4.5),
        );
      });
    });
  }

  test('dark surfaces are neutral grey, not tinted', () {
    const dark = WorkEnvironmentThemeExtension.dark;
    for (final color in [dark.cardBackground, dark.secondaryButtonFill]) {
      expect(color.r, color.g);
      expect(color.g, color.b);
    }
    expect(dark.cardBackground, AppTheme.dark.colorScheme.surface);
  });
}
