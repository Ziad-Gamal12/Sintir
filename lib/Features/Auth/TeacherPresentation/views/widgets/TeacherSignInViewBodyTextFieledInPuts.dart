import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomEmailTextField.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomPasswordTextField.dart';

class TeacherSignInViewBodyTextFieledInPuts extends StatelessWidget {
  const TeacherSignInViewBodyTextFieledInPuts({
    super.key,
    required this.teacherSignInPasswordController,
    required this.teacherSignInEmailController,
  });
  final TextEditingController teacherSignInPasswordController;
  final TextEditingController teacherSignInEmailController;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomEmailTextField(
          controller: teacherSignInEmailController,
          isIconVisible: true,
        ),
        const SizedBox(height: 10),
        CustomPasswordTextField(
          controller: teacherSignInPasswordController,
        )
      ],
    );
  }
}
