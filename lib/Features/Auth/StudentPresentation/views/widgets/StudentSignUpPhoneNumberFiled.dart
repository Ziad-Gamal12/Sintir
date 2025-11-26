// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/locale_keys.dart';

class StudentSignUpPhoneNumberFiled extends StatelessWidget {
  const StudentSignUpPhoneNumberFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
        hintText: LocaleKeys.phoneNumber,
        prefixIcon: Icons.phone_outlined,
        obscureText: false,
        onSaved: (val) {
          context.read<UserEntity>().phoneNumber = val ?? "";
        },
        textInputType: TextInputType.phone,
        validator: (value) {
          if (value!.isEmpty) {
            return LocaleKeys.phoneRequired;
          } else if (value.length != 11) {
            return LocaleKeys.phoneInvalid;
          }
          return null;
        });
  }
}
