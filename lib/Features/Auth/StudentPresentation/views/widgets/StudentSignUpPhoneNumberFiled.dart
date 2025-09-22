// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class StudentSignUpPhoneNumberFiled extends StatelessWidget {
  const StudentSignUpPhoneNumberFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: "رقم التليفون",
        prefixIcon: Icons.phone_outlined,
        obscureText: false,
        onSaved: (val) {
          context.read<UserEntity>().phoneNumber = val ?? "";
        },
        textInputType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return "ادخل رقم التليفون";
          } else if (value.length != 11) {
            return "ادخل رقم التليفون صحيح";
          }
          return null;
        });
  }
}
