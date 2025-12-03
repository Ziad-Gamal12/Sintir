import 'package:flutter/material.dart';

class ContentContainer extends StatelessWidget {
  const ContentContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.light
                ? Colors.grey.shade100
                : Colors.black26,
            blurRadius: 7,
            spreadRadius: 1,
          ),
        ],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? Colors.grey
              : Colors.white24,
          width: 0.5,
        ),
        color: theme.brightness == Brightness.light
            ? Colors.grey.shade50
            : const Color(0xFF1E1E1E),
      ),
      child: child,
    );
  }
}
