import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ChoosingUserKindTitle extends StatelessWidget {
  const ChoosingUserKindTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: AppTextStyles(context).bold32.copyWith(color: Colors.black),
    );
  }
}
