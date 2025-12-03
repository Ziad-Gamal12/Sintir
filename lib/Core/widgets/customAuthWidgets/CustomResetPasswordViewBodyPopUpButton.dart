import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class CustomResetPasswordViewBodyPopUpButton extends StatelessWidget {
  const CustomResetPasswordViewBodyPopUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pop();
      },
      child: Text(
        LocaleKeys.loginToContinue,
        style: AppTextStyles(context).semiBold16.copyWith(
            color: KMainColor,
            decoration: TextDecoration.underline,
            decorationColor: KMainColor),
      ),
    );
  }
}
