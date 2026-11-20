import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomTextFields/CustomTeaxtField.dart';

class CustomTitledTextField extends StatelessWidget {
  const CustomTitledTextField({
    super.key,
    required this.title,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.controller,
    required this.textInputType,
    this.validator,
    this.inputFormatters,
    this.onSaved,
    this.maxLines = 1,
    this.maxLength,
  });
  final String title;
  final String hintText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController? controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Function(String?)? onSaved;
  final int maxLines;
  final int? maxLength;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles(
            context,
          ).semiBold12.copyWith(color: theme.textTheme.bodyMedium?.color),
        ),
        SizedBox(height: 6),
        CustomTextField(
          hintText: hintText,
          obscureText: obscureText,
          textInputType: textInputType,
          validator: validator,
          controller: controller,
          inputFormatters: inputFormatters,
          maxLength: maxLength,
          maxLines: maxLines,
          onSaved: onSaved,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
        ),
      ],
    );
  }
}
