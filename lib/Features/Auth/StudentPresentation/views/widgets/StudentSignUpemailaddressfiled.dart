// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomEmailTextField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

class StudentSignUpemailaddressfiled extends StatefulWidget {
  const StudentSignUpemailaddressfiled({
    super.key,
  });

  @override
  State<StudentSignUpemailaddressfiled> createState() =>
      _StudentSignUpemailaddressfiledState();
}

class _StudentSignUpemailaddressfiledState
    extends State<StudentSignUpemailaddressfiled> {
  TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomEmailTextField(
      controller: controller,
      isIconVisible: true,
      onSaved: (value) {
        context.read<UserEntity>().email = value ?? "";
      },
    );
  }
}
