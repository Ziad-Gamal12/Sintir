import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class StudentSignUpemailaddressfiled extends StatelessWidget {
  const StudentSignUpemailaddressfiled({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "البريد الأكتروني",
        prefixIcon: Icons.email_outlined,
        obscureText: false,
        controller: Variables.studentSignUpEmailController,
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل البريد الأكتروني";
          } else if (!value.contains("@")) {
            return "ادخل البريد الأكتروني صحيح";
          }
          return null;
        });
  }
}
