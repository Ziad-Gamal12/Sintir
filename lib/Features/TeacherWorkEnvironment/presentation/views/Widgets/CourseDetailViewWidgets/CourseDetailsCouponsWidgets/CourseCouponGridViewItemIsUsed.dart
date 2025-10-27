import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseCouponGridViewItemIsUsed extends StatelessWidget {
  const CourseCouponGridViewItemIsUsed({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.done,
          color: Colors.green,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          "تم استخدام الكود",
          style: AppTextStyles(context).regular14.copyWith(color: Colors.green),
        ),
      ],
    );
  }
}
