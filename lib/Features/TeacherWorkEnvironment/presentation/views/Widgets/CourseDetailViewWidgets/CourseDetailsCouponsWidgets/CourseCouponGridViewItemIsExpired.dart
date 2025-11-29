import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemIsExpired extends StatelessWidget {
  const CourseCouponGridViewItemIsExpired({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.warning,
          color: Colors.red,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          LocaleKeys.invalidCoupon,
          style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
        ),
      ],
    );
  }
}
