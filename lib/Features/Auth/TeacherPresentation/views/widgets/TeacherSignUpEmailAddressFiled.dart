// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomEmailTextField.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';

/// Stateful so the controller survives rebuilds (layout changes, loading
/// state). It used to be created inside build(), which cleared the field.
class TeacherSignUpEmailAddressFiled extends StatefulWidget {
  const TeacherSignUpEmailAddressFiled({
    super.key,
  });

  @override
  State<TeacherSignUpEmailAddressFiled> createState() =>
      _TeacherSignUpEmailAddressFiledState();
}

class _TeacherSignUpEmailAddressFiledState
    extends State<TeacherSignUpEmailAddressFiled> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomEmailTextField(
      controller: controller,
      onSaved: (val) {
        context.read<UserEntity>().email = val ?? "";
      },
    );
  }
}
