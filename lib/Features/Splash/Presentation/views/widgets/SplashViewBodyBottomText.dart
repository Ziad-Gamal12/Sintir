// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SplashViewBodyBottomText extends StatelessWidget {
  const SplashViewBodyBottomText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "Sintir",
      textAlign: TextAlign.center,
      style: AppTextStyles.bold40Auto.copyWith(color: Colors.white),
    );
  }
}
