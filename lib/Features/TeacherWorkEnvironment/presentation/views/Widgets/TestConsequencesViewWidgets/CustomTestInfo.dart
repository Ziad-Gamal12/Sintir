import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomTestInfo extends StatelessWidget {
  const CustomTestInfo({
    super.key,
    required this.test,
  });

  final CourseTestEntity test;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          test.title,
          textAlign: TextAlign.center,
          style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          test.id,
          textAlign: TextAlign.center,
          style: AppTextStyles.regular14.copyWith(color: Colors.grey),
        ),
      ],
    );
  }
}
