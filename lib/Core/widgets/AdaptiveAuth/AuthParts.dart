// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/Themes/brand_palette.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class SintirWordmark extends StatelessWidget {
  const SintirWordmark({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Text(
      'Sintir',
      textDirection: TextDirection.ltr,
      style: AppTextStyles(context).bold24.copyWith(color: color, height: 1),
    );
  }
}

class AuthIllustrationStage extends StatelessWidget {
  const AuthIllustrationStage({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(32),
  });

  final Widget child;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: BrandPalette.of(context).brandStage,
        borderRadius: BorderRadius.circular(28),
      ),
      child: Padding(padding: padding, child: child),
    );
  }
}

class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final palette = BrandPalette.of(context);
    final color = Theme.of(context).colorScheme.onSurface;

    return IconButton(
      onPressed: onPressed,
      tooltip: MaterialLocalizations.of(context).backButtonTooltip,
      style: IconButton.styleFrom(
        fixedSize: const Size(44, 44),
        foregroundColor: color,
        side: BorderSide(color: palette.outline),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      icon: const Icon(Icons.arrow_back_rounded, size: 20),
    );
  }
}

class OnboardingDots extends StatelessWidget {
  const OnboardingDots({super.key, required this.count, required this.index});

  final int count;
  final int index;

  @override
  Widget build(BuildContext context) {
    final palette = BrandPalette.of(context);

    return ExcludeSemantics(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          for (var i = 0; i < count; i++)
            AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeOut,
              width: i == index ? 28 : 8,
              height: 8,
              decoration: BoxDecoration(
                color: i == index ? KMainColor : palette.dotInactive,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
        ],
      ),
    );
  }
}
