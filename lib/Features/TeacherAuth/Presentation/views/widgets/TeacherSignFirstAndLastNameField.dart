// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/Variables.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class TeacherSignFirstAndLastNameField extends StatelessWidget {
  const TeacherSignFirstAndLastNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Customteaxtfield(
              hintText: "الأسم الأول",
              prefixIcon: Icons.person_2_outlined,
              obscureText: false,
              controller: Variables.TeacherSignUpFirstNameController,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل الأسم الأول";
                } else {
                  return null;
                }
              }),
        ),
        const Customsizedbox(width: 10, height: 0),
        Expanded(
          child: Customteaxtfield(
              hintText: "الأسم الأخير",
              prefixIcon: Icons.person_2_outlined,
              obscureText: false,
              controller: Variables.TeacherSignUpLastNameController,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل الأسم الأخير";
                } else {
                  return null;
                }
              }),
        ),
      ],
    );
  }
}
