import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';

class CourseCouponGridViewItemImage extends StatelessWidget {
  const CourseCouponGridViewItemImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      Assets.assetsIconsCoupon,
      fit: BoxFit.cover,
    );
  }
}
