import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordView.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class StudentSignInForgetPasswordTextWidget extends StatelessWidget {
  const StudentSignInForgetPasswordTextWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(CustomResetPasswordView.routeName);
          },
          child: Text(
            LocaleKeys.resetPassword,
            style:
                AppTextStyles(context).semiBold13.copyWith(color: KMainColor),
          ),
        )
      ],
    );
  }
}
