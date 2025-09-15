// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomPasswordTextField.dart';

class TeacherSigninPasswordTextField extends StatefulWidget {
  const TeacherSigninPasswordTextField({super.key});

  @override
  State<TeacherSigninPasswordTextField> createState() =>
      _TeacherPasswordTextFieldState();
}

class _TeacherPasswordTextFieldState
    extends State<TeacherSigninPasswordTextField> {
  @override
  Widget build(BuildContext context) {
    return CustomPasswordTextField(
      controller: Variables.TeacherSignUpPasswordController,
    );
  }
}
