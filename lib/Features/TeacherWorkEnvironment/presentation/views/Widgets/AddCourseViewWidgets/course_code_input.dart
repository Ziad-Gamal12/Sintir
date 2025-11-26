import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class CourseCodeInput extends StatelessWidget {
  final TextEditingController controller;

  const CourseCodeInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: LocaleKeys.courseCode,
      obscureText: false,
      textInputType: TextInputType.text,
      validator: (v) =>
          v == null || v.isEmpty ? LocaleKeys.enterCourseCode : null,
    );
  }
}
