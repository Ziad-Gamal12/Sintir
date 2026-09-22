import 'package:flutter/material.dart';

class WithdrawalSurfaceCard extends StatelessWidget {
  const WithdrawalSurfaceCard({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: dark ? const Color(0xFF1E1E1E) : Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
                color: dark ? Colors.transparent : const Color(0xFFDDE5F0))),
        child: child);
  }
}
