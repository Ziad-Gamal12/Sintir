import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class SendcoursereportviewbodyTextField extends StatelessWidget {
  const SendcoursereportviewbodyTextField(
      {super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) => CustomTextField(
      controller: controller,
      maxLines: 6,
      maxLength: 500,
      hintText: LocaleKeys.hintWriteMessage,
      obscureText: false,
      textInputType: TextInputType.multiline,
      validator: (value) => (value?.trim().length ?? 0) < 10
          ? LocaleKeys.reportDescriptionTooShort
          : null);
}
