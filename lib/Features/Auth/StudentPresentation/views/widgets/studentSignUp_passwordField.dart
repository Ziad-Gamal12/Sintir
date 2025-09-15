// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomPasswordTextField.dart';

class StudentsignupPasswordfield extends StatelessWidget {
  const StudentsignupPasswordfield({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPasswordTextField(
      controller: Variables.studentSignUpPasswordController,
    );
  }
}
