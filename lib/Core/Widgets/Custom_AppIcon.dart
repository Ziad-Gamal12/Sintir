import 'package:flutter/material.dart';
import 'package:sintir/Core/Utils/imageAssets.dart';

class Custom_AppIcon extends StatelessWidget {
  const Custom_AppIcon({
    super.key,
    required this.height,
    required this.width,
  });
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.assetsImagesAppIcon,
      height: height,
      width: width,
    );
  }
}
