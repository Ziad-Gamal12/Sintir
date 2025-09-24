// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomEmailTextField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class TeacherSignUpEmailAddressFiled extends StatelessWidget {
  const TeacherSignUpEmailAddressFiled({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomEmailTextField(
      controller: TextEditingController(),
      onSaved: (val) {
        context.read<UserEntity>().email = val ?? "";
      },
    );
  }
}
