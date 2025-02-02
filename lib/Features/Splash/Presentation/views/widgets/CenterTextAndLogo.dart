// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class CenterTextAndLogo extends StatelessWidget {
  const CenterTextAndLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        LottieBuilder.asset(
          "assets/LottieFiles/SintirAnimatedLogo.json",
          repeat: false,
        )
      ],
    );
  }
}
