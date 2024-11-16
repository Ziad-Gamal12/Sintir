import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class BestSellerCoursesHeader extends StatelessWidget {
  const BestSellerCoursesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          "ألاكثر مشاهده",
          style: AppTextStyles.bold20Auto.copyWith(color: Colors.black),
        )
      ],
    );
  }
}
