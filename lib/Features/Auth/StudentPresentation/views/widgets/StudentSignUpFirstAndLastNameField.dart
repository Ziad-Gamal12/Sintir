// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class StudentSignUpFirstAndLastNameField extends StatelessWidget {
  const StudentSignUpFirstAndLastNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: CustomTextField(
            hintText: "الأسم الأول",
            prefixIcon: Icons.person_2_outlined,
            obscureText: false,
            textInputType: TextInputType.name,
            validator: (value) {
              if (value!.isEmpty) {
                return "ادخل الأسم الأول";
              } else {
                return null;
              }
            },
            onSaved: (val) {
              context.read<UserEntity>().firstName = val ?? "";
            },
          ),
        ),
        const Customsizedbox(width: 10, height: 0),
        Expanded(
          child: CustomTextField(
              hintText: "الأسم الأخير",
              prefixIcon: Icons.person_2_outlined,
              obscureText: false,
              textInputType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return "ادخل الأسم الأخير";
                } else {
                  return null;
                }
              },
              onSaved: (val) {
                context.read<UserEntity>().lastName = val ?? "";
              }),
        ),
      ],
    );
  }
}
