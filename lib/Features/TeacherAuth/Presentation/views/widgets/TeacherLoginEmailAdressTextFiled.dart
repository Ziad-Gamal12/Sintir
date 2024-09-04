import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class TeacherLoginEmailAdressTextFiled extends StatelessWidget {
  const TeacherLoginEmailAdressTextFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "البريد الالكتروني",
        prefixIcon: Icons.email_outlined,
        obscureText: false,
        controller: Variables.TeacherLoginEmailController,
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل البريد الالكتروني";
          } else if (!value.contains("@")) {
            return "ادخل البريد الالكتروني صحيح";
          }
          return null;
        });
  }
}
