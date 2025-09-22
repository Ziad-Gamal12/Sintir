// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class TeacherSignUpAddressFiled extends StatelessWidget {
  const TeacherSignUpAddressFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "العنوان",
        prefixIcon: Icons.location_on_outlined,
        obscureText: false,
        onSaved: (val) {
          context.read<UserEntity>().address = val ?? "";
        },
        textInputType: TextInputType.streetAddress,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل العنوان";
          }
          return null;
        });
  }
}
