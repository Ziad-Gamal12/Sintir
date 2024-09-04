import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class TeacherLoginViewBodyDonotHaveAccountText extends StatelessWidget {
  const TeacherLoginViewBodyDonotHaveAccountText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: [
      TextSpan(
          text: "ليس لديك حساب؟ ",
          style: AppTextStyles.semiBold16
              .copyWith(color: const Color(0xff949D9E))),
      TextSpan(
          text: "انشاء حساب",
          style: AppTextStyles.semiBold16.copyWith(color: KMainColor))
    ]));
  }
}
