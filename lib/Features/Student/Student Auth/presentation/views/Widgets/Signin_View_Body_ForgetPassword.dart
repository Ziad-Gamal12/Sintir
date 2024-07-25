import 'package:flutter/material.dart';
import 'package:sintir/Core/Utils/textStyles.dart';
import 'package:sintir/constant.dart';

class Signin_View_Body_ForgetPassword extends StatelessWidget {
  const Signin_View_Body_ForgetPassword({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Text(
        "نسيت كلمة المرور؟",
        style: textStyles.textstyle13.copyWith(color: KMainColor),
      ),
    );
  }
}
