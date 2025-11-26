import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomCourseHorizontalItemPrice extends StatelessWidget {
  const CustomCourseHorizontalItemPrice({
    super.key,
    required this.price,
  });

  final double price;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          "$price",
          style: AppTextStyles(context)
              .semiBold20
              .copyWith(color: Colors.red.shade500),
        ),
        const SizedBox(width: 4),
        Text(
          LocaleKeys.priceEgp,
          style: AppTextStyles(context).regular16,
        ),
      ],
    );
  }
}
