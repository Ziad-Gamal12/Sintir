// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomPasswordTextField.dart';

class StudentSignUpPasswordField extends StatelessWidget {
  const StudentSignUpPasswordField(
      {super.key, required this.studentSignUpPasswordController});
  final TextEditingController studentSignUpPasswordController;
  @override
  Widget build(BuildContext context) {
    return CustomPasswordTextField(
      controller: studentSignUpPasswordController,
    );
  }
}
