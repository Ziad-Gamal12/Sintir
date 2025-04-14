// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class Customfavourtitelistheader extends StatelessWidget {
  const Customfavourtitelistheader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "المفضلة",
          style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
