// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:svg_flutter/svg.dart';

class CenterTextAndLogo extends StatelessWidget {
  const CenterTextAndLogo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Sintir",
          textAlign: TextAlign.center,
          style: AppTextStyles.bold48Auto
              .copyWith(color: Colors.white, fontFamily: "Poppins"),
        ),
        const SizedBox(width: 5),
        SvgPicture.asset(
          Assets.assetsImagesSintirLogo,
          height: 80,
          width: 80,
        )
      ],
    );
  }
}
