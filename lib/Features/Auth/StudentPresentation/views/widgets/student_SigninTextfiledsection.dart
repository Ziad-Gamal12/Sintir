// ignore_for_file: file_names, camel_case_types

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomEmailTextField.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomPasswordTextField.dart';

class student_SigninTextfiledsection extends StatelessWidget {
  const student_SigninTextfiledsection(
      {super.key,
      required this.studentSignInEmailController,
      required this.studentSignInPasswordController});
  final TextEditingController studentSignInEmailController;
  final TextEditingController studentSignInPasswordController;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomEmailTextField(
          controller: studentSignInEmailController,
          isIconVisible: true,
        ),
        const Customsizedbox(width: 0, height: 10),
        CustomPasswordTextField(
          controller: studentSignInPasswordController,
        )
      ],
    );
  }
}
