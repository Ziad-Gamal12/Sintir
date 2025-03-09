import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class Reviewvedioinfo extends StatelessWidget {
  const Reviewvedioinfo({super.key, required this.vedioEntity});
  final Coursevedioitementity vedioEntity;
  @override
  Widget build(
    BuildContext context,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text.rich(TextSpan(children: [
            TextSpan(
              text: "عنوان الفيديو: ",
              style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
            ),
            TextSpan(
              text: vedioEntity.title,
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
              text: "مده الفيديو: ",
              style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
            ),
            TextSpan(
              text: "${vedioEntity.durationTime.toString()} دقيقة",
              style: AppTextStyles.regular16.copyWith(color: Colors.grey),
            ),
          ])),
        )
      ],
    );
  }
}
