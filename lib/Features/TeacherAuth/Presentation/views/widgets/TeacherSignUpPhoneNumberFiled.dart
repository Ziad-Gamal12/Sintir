// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class TeacherSignUpPhoneNumberFiled extends StatelessWidget {
  const TeacherSignUpPhoneNumberFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "رقم التليفون",
        prefixIcon: Icons.phone_outlined,
        obscureText: false,
        controller: Variables.TeacherSignUpPhoneNumberController,
        textInputType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل رقم التليفون";
          }
          return null;
        });
  }
}
