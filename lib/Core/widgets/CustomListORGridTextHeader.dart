// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomListORGridTextHeader extends StatelessWidget {
  CustomListORGridTextHeader(
      {super.key, required this.text, this.position, this.trailing});
  final String text;
  MainAxisAlignment? position;
  Widget? trailing;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: position ?? MainAxisAlignment.start,
      children: [
        Text(
          text,
          style:
              AppTextStyles(context).semiBold20.copyWith(color: Colors.black),
        ),
        const Spacer(),
        trailing != null ? trailing! : const SizedBox(),
      ],
    );
  }
}
