// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Custommycoursesgridheader extends StatelessWidget {
  const Custommycoursesgridheader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "كورساتي",
          style: AppTextStyles(context).bold20.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
