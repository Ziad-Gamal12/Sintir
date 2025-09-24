import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/customAuthWidgets/CustomResetPasswordView.dart';
import 'package:sintir/constant.dart';

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
            "نسيت كلمة المرور؟",
            style: AppTextStyles.semiBold13Auto.copyWith(color: KMainColor),
          ),
        )
      ],
    );
  }
}
