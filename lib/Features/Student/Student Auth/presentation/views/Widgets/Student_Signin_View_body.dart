// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/Utils/textStyles.dart';
import 'package:sintir/Core/Widgets/Custom_AppBar.dart';
import 'package:sintir/Core/Widgets/Custom_Button.dart';
import 'package:sintir/Core/Widgets/Custom_Separated_Widget.dart';
import 'package:sintir/Features/Student/Student%20Auth/presentation/views/Widgets/Signin_View_Body_ForgetPassword.dart';
import 'package:sintir/Features/Student/Student%20Auth/presentation/views/Widgets/Student_SigninView_body_email&Password.dart';
import 'package:sintir/constant.dart';

class Student_Signin_View_body extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
      ),
      child: ListView(
        physics: NeverScrollableScrollPhysics(),
        children: [
          CustomAppbar(
            title: "تسجيل الدخول كطالب",
            onPressed: () {},
          ),
          SizedBox(
            height: 20,
          ),
          StudentSigninviewBodyEmailandpassword(),
          SizedBox(
            height: 16,
          ),
          Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            Signin_View_Body_ForgetPassword(),
          ]),
          SizedBox(
            height: 37,
          ),
          CustomButton(
              widget: Text("تسجيل دخول"),
              onTap: () {},
              borderradius: BorderRadius.circular(16)),
          SizedBox(
            height: 37,
          ),
          Text.rich(TextSpan(
              text: "ليس لديك حساب؟ ",
              style: textStyles.textstyle13.copyWith(color: KMainColor),
              children: [
                TextSpan(
                  text: "انشاء حساب",
                  style: textStyles.textstyle13.copyWith(color: KSecondColor),
                )
              ])),
          SizedBox(
            height: 37,
          ),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              customSeparatedWidget(),
              SizedBox(
                width: 17,
              ),
              Text("أو"),
              SizedBox(
                width: 17,
              ),
              customSeparatedWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
