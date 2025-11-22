// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
            prefixIcon: FontAwesomeIcons.user,
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
              prefixIcon: FontAwesomeIcons.user,
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
