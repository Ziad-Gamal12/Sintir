import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseCouponGridViewItemIsInActive extends StatelessWidget {
  const CourseCouponGridViewItemIsInActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(
          Icons.circle,
          color: Colors.red,
          size: 20,
        ),
        const SizedBox(width: 10),
        Text(
          "تم تعطيل الكود",
          style: AppTextStyles(context).regular14.copyWith(color: Colors.red),
        ),
      ],
    );
  }
}
