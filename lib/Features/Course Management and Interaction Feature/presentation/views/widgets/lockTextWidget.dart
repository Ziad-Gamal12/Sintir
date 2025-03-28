import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class LockText extends StatelessWidget {
  const LockText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "هذا المحتوى مغلق",
      style: AppTextStyles.semiBold16.copyWith(color: Colors.red.shade700),
    );
  }
}
