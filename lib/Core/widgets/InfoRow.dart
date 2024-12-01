import 'package:flutter/material.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final TextStyle? textStyle;

  const InfoRow({
    super.key,
    this.icon,
    required this.label,
    this.textStyle,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: const Color(0xff818181), size: 24),
        const SizedBox(width: 4),
        Text(
          label,
          style: textStyle ??
              const TextStyle(color: Color(0xff818181), fontSize: 10),
        ),
      ],
    );
  }
}
