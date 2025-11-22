// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  IconData? prefixIcon;
  Widget? suffixIcon;
  final bool obscureText;
  TextEditingController? controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  Function(String?)? onSaved;
  int maxLines;

  CustomTextField({
    super.key,
    this.inputFormatters,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.obscureText,
    this.controller,
    required this.textInputType,
    required this.validator,
    this.onSaved,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    final baseBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFE4E6E8),
        width: .5,
      ),
    );

    final focusedBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: KMainColor,
        width: 1,
      ),
    );

    final errorBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(
        color: Color(0xFFE03131),
        width: 1,
      ),
    );

    final disabledBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: const BorderSide(
        color: Color(0xFFCED4DA),
        width: 1,
      ),
    );

    return TextFormField(
      onSaved: onSaved,
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      style: AppTextStyles(context).semiBold14.copyWith(
            color: const Color(0xFF1C1C1E),
          ),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: AppTextStyles(context)
            .semiBold14
            .copyWith(color: const Color(0xFFB1B1B5)),

        prefixIcon: Icon(
          prefixIcon,
          size: 24,
          color: const Color(0xFF6C6C70),
        ),

        suffixIcon: suffixIcon,

        // Borders
        enabledBorder: baseBorder,
        border: baseBorder,
        focusedBorder: focusedBorder,
        errorBorder: errorBorder,
        focusedErrorBorder: errorBorder,
        disabledBorder: disabledBorder,

        filled: true,
        fillColor: const Color(0xFFF8F9FB),

        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
      ),
    );
  }
}
