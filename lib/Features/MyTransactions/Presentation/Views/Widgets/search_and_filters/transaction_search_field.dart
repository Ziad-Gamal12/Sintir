import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomSearchTextField.dart';

class TransactionSearchField extends StatelessWidget {
  const TransactionSearchField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return CustomSearchTextField(controller: controller, onChanged: onChanged);
  }
}
