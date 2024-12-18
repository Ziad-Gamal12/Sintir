import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomCountWidget extends StatelessWidget {
  const CustomCountWidget({
    super.key,
    required this.countColor,
    required this.count,
    required this.countTextColor,
  });

  final Color countColor;
  final String count;
  final Color countTextColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
          color: countColor, borderRadius: BorderRadius.circular(8)),
      child: Text(
        count,
        style: AppTextStyles.regular16.copyWith(color: countTextColor),
      ),
    );
  }
}
