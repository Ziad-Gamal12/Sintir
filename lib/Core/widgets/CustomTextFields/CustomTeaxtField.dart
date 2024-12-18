// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customteaxtfield extends StatelessWidget {
  final String hintText;
  IconData? prefixIcon;
  Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;
  int maxLines;
  Customteaxtfield(
      {super.key,
      this.inputFormatters,
      required this.hintText,
      this.prefixIcon,
      this.suffixIcon,
      required this.obscureText,
      required this.controller,
      required this.textInputType,
      required this.validator,
      this.maxLines = 1});

  @override
  Widget build(BuildContext context) {
    var border = const OutlineInputBorder(borderSide: BorderSide.none);
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: validator,
      maxLines: maxLines,
      decoration: InputDecoration(
          hintText: hintText,
          hintStyle:
              AppTextStyles.bold13.copyWith(color: const Color(0xffAEAEB2)),
          prefixIcon: Icon(
            prefixIcon,
            size: 24,
            color: const Color(0xffAEAEB2),
          ),
          suffixIcon: suffixIcon,
          border: border,
          focusedBorder: border,
          enabledBorder: border,
          filled: true,
          focusColor: const Color(0xffF9FAFA),
          fillColor: const Color(0xffF9FAFA)),
    );
  }
}
