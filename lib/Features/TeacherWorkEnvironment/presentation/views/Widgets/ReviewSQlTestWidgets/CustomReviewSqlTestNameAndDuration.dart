import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';

class CustomReviewSqlTestNameAndDuration extends StatelessWidget {
  const CustomReviewSqlTestNameAndDuration({
    super.key,
    required this.coursetestentity,
  });

  final Coursetestentity coursetestentity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "عنوان الامتحان: ",
              style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
            ),
            TextSpan(
              text: coursetestentity.title,
              style: AppTextStyles.regular16.copyWith(color: Colors.grey),
            ),
          ])),
        ),
        const Expanded(
          flex: 1,
          child: SizedBox(),
        ),
        Expanded(
          flex: 2,
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "مده الامتحان: ",
              style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
            ),
            TextSpan(
              text: "${coursetestentity.durationTime.toString()} دقيقة",
              style: AppTextStyles.regular16.copyWith(color: Colors.grey),
            ),
          ])),
        )
      ],
    );
  }
}
