import 'package:flutter/material.dart';

class StudentStatItemIcon extends StatelessWidget {
  const StudentStatItemIcon({
    super.key,
    required this.icon,
    required this.backgroundColor,
  });

  final String icon;
  final Color backgroundColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: 42,
      height: 42,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            backgroundColor.withOpacity(0.85),
            isDark ? Colors.white10 : Colors.white.withOpacity(0.4),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: backgroundColor.withOpacity(isDark ? 0.2 : 0.35),
            blurRadius: 25,
            offset: const Offset(0, 12),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Image.asset(
          icon,
          color: isDark ? Colors.white70 : Colors.black87,
        ),
      ),
    );
  }
}
