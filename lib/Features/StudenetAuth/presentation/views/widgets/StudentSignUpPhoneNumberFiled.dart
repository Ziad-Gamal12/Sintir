// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTeaxtField.dart';

class StudentSignUpPhoneNumberFiled extends StatelessWidget {
  const StudentSignUpPhoneNumberFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "رقم التليفون",
        prefixIcon: Icons.phone_outlined,
        obscureText: false,
        controller: Variables.studentSignUpPhoneNumberController,
        textInputType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل رقم التليفون";
          } else if (value.length < 11 || value.length > 11) {
            return "ادخل رقم التليفون صحيح";
          }
          return null;
        });
  }
}
