import 'package:flutter/material.dart';
import 'package:sintir/Core/Utils/imageAssets.dart';

class SplashView_Body_TopRight_Icon extends StatelessWidget {
  const SplashView_Body_TopRight_Icon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          Assets.assetsImagesSplashCornerIcon,
          height: 80,
          width: 75,
          color: Color(0xff80A0D2).withOpacity(0.3),
        ),
      ],
    );
  }
}
