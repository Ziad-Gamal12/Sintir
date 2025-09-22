// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class StudentSignUpemailaddressfiled extends StatelessWidget {
  const StudentSignUpemailaddressfiled({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "البريد الأكتروني",
        prefixIcon: Icons.email_outlined,
        obscureText: false,
        onSaved: (val) {
          context.read<UserEntity>().email = val ?? "";
        },
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل البريد الأكتروني";
          } else if (!value.contains("@")) {
            return "ادخل البريد الأكتروني صحيح";
          } else if (!RegExp(
                  r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$')
              .hasMatch(value)) {
            return "ادخل البريد الأكتروني الصحيح";
          }
          return null;
        });
  }
}
