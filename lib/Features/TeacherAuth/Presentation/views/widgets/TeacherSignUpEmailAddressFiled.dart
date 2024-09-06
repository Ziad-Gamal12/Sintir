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
        controller: Variables.TeacherSignUpEmailController,
        textInputType: TextInputType.emailAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل البريد الأكتروني";
          } else if (!value.contains("@")) {
            return "ادخل البريد الأكتروني صحيح";
          } else if (value.contains(RegExp(
              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))) {
            return "ادخل البريد الأكتروني صحيح";
          }
          return null;
        });
  }
}
