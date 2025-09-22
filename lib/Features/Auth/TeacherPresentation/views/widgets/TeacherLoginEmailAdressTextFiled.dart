// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class TeacherLoginEmailAdressTextFiled extends StatelessWidget {
  const TeacherLoginEmailAdressTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "البريد الالكتروني",
        prefixIcon: Icons.email_outlined,
        obscureText: false,
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل البريد الالكتروني";
          } else if (!value.contains("@")) {
            return "ادخل البريد الالكتروني صحيح";
          } else if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(value)) {
            return "ادخل البريد الأكتروني الصحيح";
          }
          return null;
        });
  }
}
