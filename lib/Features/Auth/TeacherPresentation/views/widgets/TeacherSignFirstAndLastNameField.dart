// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomSizedBox.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/locale_keys.dart';

class TeacherSignFirstAndLastNameField extends StatelessWidget {
  const TeacherSignFirstAndLastNameField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        children: [
          Expanded(
            child: CustomTextField(
                hintText: LocaleKeys.firstName,
                prefixIcon: Icons.person,
                obscureText: false,
                textInputType: TextInputType.name,
                onSaved: (val) {
                  context.read<UserEntity>().firstName = val ?? "";
                },
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.enterFirstName;
                  } else {
                    return null;
                  }
                }),
          ),
          const Customsizedbox(width: 10, height: 0),
          Expanded(
            child: CustomTextField(
                hintText: LocaleKeys.lastName,
                prefixIcon: Icons.person,
                obscureText: false,
                onSaved: (val) {
                  context.read<UserEntity>().lastName = val ?? "";
                },
                textInputType: TextInputType.name,
                validator: (value) {
                  if (value!.isEmpty) {
                    return LocaleKeys.enterLastName;
                  } else {
                    return null;
                  }
                }),
          ),
        ],
      ),
    );
  }
}
