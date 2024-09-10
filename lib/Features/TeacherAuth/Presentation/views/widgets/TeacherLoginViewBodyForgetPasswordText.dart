import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/teacherResetPasswordView.dart';
import 'package:sintir/constant.dart';

class TeacherLoginViewBodyForgetPasswordText extends StatelessWidget {
  const TeacherLoginViewBodyForgetPasswordText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {
            GoRouter.of(context).push(teacherResetPasswordView.routeName);
          },
          child: Text(
            "نسيت كلمة المرور؟",
            style: AppTextStyles.semiBold13Auto.copyWith(color: KMainColor),
          ),
        ),
      ],
    );
  }
}
