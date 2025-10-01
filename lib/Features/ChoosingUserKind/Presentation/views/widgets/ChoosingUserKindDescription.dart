import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class ChoosingUserKindDescription extends StatelessWidget {
  const ChoosingUserKindDescription({super.key, required this.description});
  final String description;

  @override
  Widget build(BuildContext context) {
    return Text(
      description,
      textAlign: TextAlign.justify,
      style: AppTextStyles(context)
          .regular16
          .copyWith(color: const Color(0xff818181)),
    );
  }
}
