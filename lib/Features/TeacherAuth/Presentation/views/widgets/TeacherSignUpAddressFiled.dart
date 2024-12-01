// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class TeacherSignUpAddressFiled extends StatelessWidget {
  const TeacherSignUpAddressFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Customteaxtfield(
        hintText: "العنوان",
        prefixIcon: Icons.location_on_outlined,
        obscureText: false,
        controller: Variables.TeacherSignUpAdressController,
        textInputType: TextInputType.streetAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل العنوان";
          }
          return null;
        });
  }
}
