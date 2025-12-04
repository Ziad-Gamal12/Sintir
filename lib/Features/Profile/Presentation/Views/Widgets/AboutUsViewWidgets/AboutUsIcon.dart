import 'package:flutter/material.dart';

class AboutUsIcon extends StatelessWidget {
  const AboutUsIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: isDark
            ? Colors.white.withOpacity(0.05)
            : Colors.black.withOpacity(0.05),
        boxShadow: [
          BoxShadow(
            color: isDark
                ? Colors.blueAccent.withOpacity(.25)
                : Colors.blueAccent.withOpacity(.3),
            blurRadius: 20,
            spreadRadius: -2,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Icon(
        Icons.info_outline_rounded,
        color: isDark ? Colors.white70 : Colors.black87,
        size: 32,
      ),
    );
  }
}
