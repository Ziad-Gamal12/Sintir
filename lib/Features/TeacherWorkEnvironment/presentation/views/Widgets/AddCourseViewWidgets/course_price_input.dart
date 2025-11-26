import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';
import 'package:sintir/locale_keys.dart';

class CoursePriceInput extends StatelessWidget {
  final TextEditingController controller;

  const CoursePriceInput({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: controller,
      hintText: LocaleKeys.price,
      obscureText: false,
      textInputType: TextInputType.number,
      validator: (value) =>
          value == null || value.isEmpty ? LocaleKeys.enterPrice : null,
    );
  }
}
