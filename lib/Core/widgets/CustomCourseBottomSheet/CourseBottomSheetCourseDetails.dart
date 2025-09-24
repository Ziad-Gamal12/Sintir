// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/BottomSheetNavigationRequirmentsEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CourseBottomSheetCourseDetails extends StatelessWidget {
  const CourseBottomSheetCourseDetails({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    CourseEntity course = context
        .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
        .course;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
              text: course.title,
              style: AppTextStyles.semiBold20.copyWith(color: Colors.black)),
        ])),
        const SizedBox(
          height: 10,
        ),
        Text(
          course.description,
          style: AppTextStyles.regular10.copyWith(color: Colors.black),
        ),
        const SizedBox(
          height: 20,
        ),
        context
                    .read<DisplayCourseBottomsheetNavigationRequirmentsEntity>()
                    .isSubscribed ==
                true
            ? Container()
            : Text.rich(
                TextSpan(children: [
                  TextSpan(
                      text: "المبلغ :    ",
                      style: AppTextStyles.semiBold20
                          .copyWith(color: Colors.black)),
                  TextSpan(
                      text: " ${course.price}\$ (شهرى)",
                      style: AppTextStyles.bold20Auto
                          .copyWith(color: KSecondaryColor))
                ]),
              ),
      ],
    );
  }
}
