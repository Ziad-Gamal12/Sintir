// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';
import 'package:svg_flutter/svg.dart';

class CustomSearchTextField extends StatelessWidget {
  const CustomSearchTextField({
    super.key,
    required this.controller,
  });
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final Color fillColor = isDark ? Colors.grey.shade800 : Colors.white;
    final Color hintColor =
        isDark ? Colors.grey.shade400 : const Color(0xff949D9E);
    final BoxShadow shadow = BoxShadow(
      color: isDark ? Colors.grey.withOpacity(0.1) : Colors.grey.shade200,
      spreadRadius: 1,
      blurRadius: 7,
      offset: const Offset(0, 8),
    );

    return Container(
      decoration: BoxDecoration(
        color: fillColor,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [shadow],
      ),
      child: TextField(
        controller: controller,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
        ),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 8, bottom: 7, right: 14, left: 16),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 20, minHeight: 20),
          filled: true,
          fillColor: fillColor,
          hintText: LocaleKeys.searchplaceholder,
          hintStyle:
              AppTextStyles(context).regular13.copyWith(color: hintColor),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SvgPicture.asset(
              Assets.assetsIconsSVGIconsSearchIcon,
              fit: BoxFit.fill,
              color: isDark ? Colors.white70 : null,
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}
