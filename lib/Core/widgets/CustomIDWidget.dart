import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customidwidget extends StatelessWidget {
  const Customidwidget({super.key, required this.id});
  final String id;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          id,
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
        ),
        const Icon(
          Icons.copy_outlined,
          color: Color(0xff818181),
          size: 10,
        )
      ],
    );
  }
}
