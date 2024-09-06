import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/TeacherSignUpView.dart';
import 'package:sintir/constant.dart';

class TeacherLoginViewBodyDonotHaveAccountText extends StatelessWidget {
  const TeacherLoginViewBodyDonotHaveAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GoRouter.of(context).push(TeacherSignUpView.routeName);
      },
      child: Text.rich(TextSpan(children: [
        TextSpan(
            text: "ليس لديك حساب؟ ",
            style: AppTextStyles.semiBold16
                .copyWith(color: const Color(0xff949D9E))),
        TextSpan(
            text: "انشاء حساب",
            style: AppTextStyles.semiBold16.copyWith(color: KMainColor))
      ])),
    );
  }
}
