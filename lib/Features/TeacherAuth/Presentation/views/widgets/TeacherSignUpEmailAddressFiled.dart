import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class TeacherSignUpEmailAddressFiled extends StatelessWidget {
  const TeacherSignUpEmailAddressFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "البريد الأكتروني",
        prefixIcon: Icons.email_outlined,
        obscureText: false,
        controller: Variables.TeacherEmailController,
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل البريد الأكتروني";
          }
        });
  }
}
