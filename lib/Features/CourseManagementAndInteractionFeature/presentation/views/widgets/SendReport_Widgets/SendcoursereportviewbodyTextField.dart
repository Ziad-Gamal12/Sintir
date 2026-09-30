import 'package:flutter/material.dart';
import 'package:sintir/locale_keys.dart';

class SendcoursereportviewbodyTextField extends StatelessWidget {
  const SendcoursereportviewbodyTextField(
      {super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) => TextFormField(
      controller: controller,
      minLines: 4,
      maxLines: 6,
      maxLength: 500,
      decoration: InputDecoration(hintText: LocaleKeys.hintWriteMessage),
      validator: (value) => (value?.trim().length ?? 0) < 10
          ? LocaleKeys.reportDescriptionTooShort
          : null);
}
