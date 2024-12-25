import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CoursIntroductionviewbodydescription extends StatelessWidget {
  const CoursIntroductionviewbodydescription({super.key, required this.course});
  final CourseEntity course;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "الوصف",
          style: AppTextStyles.bold24.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          course.description,
          style:
              AppTextStyles.regular10.copyWith(color: const Color(0xff818181)),
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
