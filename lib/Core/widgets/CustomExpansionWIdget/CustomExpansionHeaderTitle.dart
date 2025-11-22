import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomExpansionHeaderTitle extends StatelessWidget {
  const CustomExpansionHeaderTitle({super.key, required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
    );
  }
}
