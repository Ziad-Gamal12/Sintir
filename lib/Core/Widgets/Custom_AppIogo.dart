import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:sintir/Core/Utils/imageAssets.dart';

class Custom_AppLogo extends StatelessWidget {
  const Custom_AppLogo({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      Assets.assetsImagesAppLogo,
      height: height,
      width: width,
    );
  }
}
