import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';

class AppSkeletonizerConfig extends StatelessWidget {
  const AppSkeletonizerConfig({super.key, required this.child});
  final Widget child;

  static PaintingEffect _effect(Brightness brightness) =>
      brightness == Brightness.dark
      ? const ShimmerEffect(
          baseColor: Color(0xFF2A2A2A),
          highlightColor: Color(0xFF353535),
        )
      : const ShimmerEffect(
          baseColor: Color(0xFFE6E9F0),
          highlightColor: Color(0xFFF3F5F9),
        );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return SkeletonizerConfig(
      data: SkeletonizerConfigData(
        effectResolver: _effect,
        brightness: theme.brightness,
        containersColor: isDark ? theme.colorScheme.surface : null,
      ),
      child: child,
    );
  }
}
