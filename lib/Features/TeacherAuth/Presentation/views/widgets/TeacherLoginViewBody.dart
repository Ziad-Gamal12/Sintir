// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginEmailAdressTextFiled.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginPasswordTextField.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginViewBodyDonotHaveAccountText.dart';
import 'package:sintir/Features/TeacherAuth/Presentation/views/widgets/TeacherLoginViewBodyForgetPasswordText.dart';
import 'package:sintir/constant.dart';

class TeacherLoginViewBody extends StatefulWidget {
  const TeacherLoginViewBody({super.key});

  @override
  State<TeacherLoginViewBody> createState() => _TeacherLoginViewBodyState();
}

class _TeacherLoginViewBodyState extends State<TeacherLoginViewBody> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
          child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: KHorizontalPadding, vertical: 24),
        child: Column(
          children: [
            const TeacherLoginEmailAdressTextFiled(),
            const Customsizedbox(width: 0, height: 10),
            Teacherloginpasswordtextfield(),
            const Customsizedbox(width: 0, height: 16),
            const TeacherLoginViewBodyForgetPasswordText(),
            const Customsizedbox(width: 0, height: 30),
            Custombutton(
                text: "تسجيل دخول",
                color: KMainColor,
                textColor: Colors.white,
                onPressed: () {}),
            const Customsizedbox(width: 0, height: 30),
            const TeacherLoginViewBodyDonotHaveAccountText()
          ],
        ),
      )),
    );
  }
}
