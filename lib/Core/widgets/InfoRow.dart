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
            ? Icon(icon, color: Colors.black87, size: 18)
            : Text(
                headline!,
                style: AppTextStyles(context)
                    .semiBold12
                    .copyWith(color: Colors.black),
              ),
        const SizedBox(width: 8),
        Text(
          label,
          style: textStyle ??
              AppTextStyles(context).regular10.copyWith(color: Colors.black87),
        ),
      ],
    );
  }
}
