// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomPasswordTextField.dart';

class TeacherSignUpPasswordTextField extends StatelessWidget {
  const TeacherSignUpPasswordTextField(
      {super.key, required this.teacherSignUpPasswordController});
  final TextEditingController teacherSignUpPasswordController;
  @override
  Widget build(BuildContext context) {
    return CustomPasswordTextField(
      controller: teacherSignUpPasswordController,
    );
  }
}
