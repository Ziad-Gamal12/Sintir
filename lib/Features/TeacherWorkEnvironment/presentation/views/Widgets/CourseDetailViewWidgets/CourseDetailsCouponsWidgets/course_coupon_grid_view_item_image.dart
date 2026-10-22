import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/imageAssets.dart';

class CourseCouponGridViewItemImage extends StatelessWidget {
  const CourseCouponGridViewItemImage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color? colorFilter = theme.brightness == Brightness.dark
        ? theme.colorScheme.onSurface
        : null;

    return Image.asset(
      Assets.assetsIconsCoupon,
      fit: BoxFit.cover,
      height: 18,
      width: 18,
      color: colorFilter,
    );
  }
}
