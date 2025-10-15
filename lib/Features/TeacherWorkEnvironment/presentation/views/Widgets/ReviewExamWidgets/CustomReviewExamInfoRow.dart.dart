import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomReviewExamInfoRow extends StatelessWidget {
  const CustomReviewExamInfoRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.black, size: 25),
        const SizedBox(width: 5),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: [
                TextSpan(
                  text: label,
                  style: AppTextStyles(context)
                      .semiBold16
                      .copyWith(color: Colors.black),
                ),
                TextSpan(
                  text: value,
                  style: AppTextStyles(context)
                      .regular16
                      .copyWith(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
