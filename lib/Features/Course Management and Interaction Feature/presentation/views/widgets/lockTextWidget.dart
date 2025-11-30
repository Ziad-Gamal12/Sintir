import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class LockText extends StatelessWidget {
  const LockText({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      LocaleKeys.contentLocked,
      style: AppTextStyles(context)
          .semiBold16
          .copyWith(color: Colors.red.shade700),
    );
  }
}
