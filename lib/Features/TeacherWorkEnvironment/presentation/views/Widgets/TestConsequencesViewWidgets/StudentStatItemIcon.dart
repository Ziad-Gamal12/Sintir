import 'package:flutter/material.dart';

class StudentStatItemIcon extends StatelessWidget {
  const StudentStatItemIcon({
    super.key,
    required this.icon,
    required this.backgroundColor,
    this.size = 32,
  });

  final String icon;
  final Color backgroundColor;
  final double size;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final iconColor = isDark
        ? Color.lerp(backgroundColor, Colors.white, 0.45)!
        : backgroundColor;

    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: backgroundColor.withValues(alpha: isDark ? 0.16 : 0.10),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: backgroundColor.withValues(alpha: isDark ? 0.25 : 0.16),
          width: 0.75,
        ),
      ),
      padding: const EdgeInsets.all(6),
      child: Image.asset(
        icon,
        color: iconColor,
        fit: BoxFit.contain,
        errorBuilder: (_, _, _) =>
            Icon(Icons.bar_chart_rounded, size: size * 0.55, color: iconColor),
      ),
    );
  }
}
