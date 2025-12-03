import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomResetPasswordViewBodyDescription extends StatelessWidget {
  const CustomResetPasswordViewBodyDescription({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        LocaleKeys.resetPasswordDescription,
        style: AppTextStyles(context).semiBold14,
        textAlign: TextAlign.center,
      ),
    );
  }
}
