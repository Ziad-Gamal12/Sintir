import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class AboutUsTitle extends StatelessWidget {
  const AboutUsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final secondary = scheme.secondary;
    final onHeader = theme.brightness == Brightness.dark
        ? scheme.onSurface
        : scheme.onPrimary;
    final styles = AppTextStyles(context);

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: onHeader.withValues(alpha: 0.16),
            border: Border.all(color: onHeader.withValues(alpha: 0.25)),
          ),
          child: Text(
            LocaleKeys.profileAbout,
            style: styles.regular12.copyWith(
              fontWeight: FontWeight.w600,
              color: onHeader,
            ),
          ),
        ),
        const SizedBox(height: 14),
        Semantics(
          header: true,
          child: Text(
            'Sintir',
            textAlign: TextAlign.center,
            style: styles.semiBold24.copyWith(
              fontWeight: FontWeight.w800,
              letterSpacing: 0.6,
              color: onHeader,
            ),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          height: 4,
          width: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: secondary,
          ),
        ),
      ],
    );
  }
}
