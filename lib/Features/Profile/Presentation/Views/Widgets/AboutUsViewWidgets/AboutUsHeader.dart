import 'package:flutter/material.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsIcon.dart';
import 'package:sintir/Features/Profile/Presentation/Views/Widgets/AboutUsViewWidgets/AboutUsTitle.dart';

class AboutUsHeader extends StatelessWidget {
  const AboutUsHeader({super.key});

  static const double _radius = 24;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final primary = theme.colorScheme.primary;
    final secondary = theme.colorScheme.secondary;
    final start = isDark ? Color.lerp(primary, Colors.black, 0.15)! : primary;
    final end = Color.lerp(primary, Colors.black, isDark ? 0.55 : 0.35)!;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_radius),
        gradient: LinearGradient(
          colors: [start, end],
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
        ),
        boxShadow: [
          BoxShadow(
            color: primary.withValues(alpha: isDark ? 0.12 : 0.35),
            offset: const Offset(0, 16),
            blurRadius: 32,
            spreadRadius: -6,
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_radius),
        child: Stack(
          children: [
            PositionedDirectional(
              top: -40,
              end: -30,
              child: _Bubble(
                size: 140,
                color: secondary.withValues(alpha: 0.18),
              ),
            ),
            PositionedDirectional(
              bottom: -50,
              start: -40,
              child: _Bubble(
                size: 160,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 36, horizontal: 24),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ExcludeSemantics(child: AboutUsIcon()),
                    SizedBox(height: 20),
                    AboutUsTitle(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Bubble extends StatelessWidget {
  const _Bubble({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: SizedBox.square(dimension: size),
    );
  }
}
