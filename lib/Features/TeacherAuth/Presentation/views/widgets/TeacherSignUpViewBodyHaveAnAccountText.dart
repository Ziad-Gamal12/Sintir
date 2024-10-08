import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class TeacherSignUpViewBodyHaveAnAccountText extends StatelessWidget {
  const TeacherSignUpViewBodyHaveAnAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).pop();
      },
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: "لديك حساب بالفعل ؟ ",
            style: AppTextStyles.semiBold16
                .copyWith(color: const Color(0xff949D9E))),
        TextSpan(
            text: "تسجيل الدخول",
            style: AppTextStyles.semiBold16.copyWith(color: KMainColor))
      ])),
    );
  }
}
