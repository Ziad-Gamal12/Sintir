import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class InfoRow extends StatelessWidget {
  final IconData? icon;
  final String label;
  final TextStyle? textStyle;
  final String? headline;
  const InfoRow(
      {super.key,
      this.icon,
      required this.label,
      this.textStyle,
      this.headline});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        headline == null
            ? Icon(icon, color: const Color(0xff818181), size: 18)
            : Text(
                headline!,
                style: AppTextStyles.semiBold12.copyWith(color: Colors.black),
              ),
        const SizedBox(width: 5),
        Text(
          label,
          style: textStyle ??
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
        ),
      ],
    );
  }
}
