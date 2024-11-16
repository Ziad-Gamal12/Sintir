import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Leatestcoursesheader extends StatelessWidget {
  const Leatestcoursesheader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "أحدث الكورسات",
          style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
        )
      ],
    );
  }
}
