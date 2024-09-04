// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customteaxtfield extends StatelessWidget {
  final String hintText;
  final IconData prefixIcon;
  Widget? suffixIcon;
  final bool obscureText;
  final TextEditingController controller;
  final TextInputType textInputType;
  final String? Function(String?)? validator;
  List<TextInputFormatter>? inputFormatters;

  Customteaxtfield(
      {super.key,
      this.inputFormatters,
      required this.hintText,
      required this.prefixIcon,
      this.suffixIcon,
      required this.obscureText,
      required this.controller,
      required this.textInputType,
      required this.validator});

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderSide: const BorderSide(color: Color(0xFFE6E9EA), width: 1.0),
        borderRadius: BorderRadius.circular(4));
    return TextFormField(
      inputFormatters: inputFormatters,
      controller: controller,
      keyboardType: textInputType,
      obscureText: obscureText,
      validator: validator,
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
