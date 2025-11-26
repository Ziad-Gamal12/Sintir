import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class CourseTitleInput extends StatelessWidget {
  final TextEditingController controller;

  const CourseTitleInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: LocaleKeys.courseName,
      obscureText: false,
      textInputType: TextInputType.text,
      validator: (value) =>
          value == null || value.isEmpty ? LocaleKeys.enterCourseName : null,
    );
  }
}
