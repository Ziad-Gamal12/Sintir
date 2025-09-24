import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SubscribtionViewBodyCourseDetailsTitle extends StatelessWidget {
  const SubscribtionViewBodyCourseDetailsTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "تفاصيل الكورس",
      style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
    );
  }
}
