// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg.dart';

class CustomSearchTextField extends StatefulWidget {
  const CustomSearchTextField(
      {super.key, required this.controller, required this.onSearchChanged});
  final TextEditingController controller;
  final void Function() onSearchChanged;
  @override
  State<CustomSearchTextField> createState() => _CustomSearchTextFieldState();
}

class _CustomSearchTextFieldState extends State<CustomSearchTextField> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.controller.addListener(widget.onSearchChanged);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            spreadRadius: 1,
            blurRadius: 7,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 8, bottom: 7, right: 14, left: 16),
          prefixIconConstraints:
              const BoxConstraints(minWidth: 20, minHeight: 20),
          filled: true,
          fillColor: Colors.white,
          hintText: 'ابحث عن.......',
          hintStyle: AppTextStyles(context)
              .regular13
              .copyWith(color: const Color(0xff949D9E)),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: SvgPicture.asset(
              Assets.assetsImagesSearchIcon,
              fit: BoxFit.fill,
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
