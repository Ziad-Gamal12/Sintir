import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomCourseDetailsBodyCourseInfoTexts extends StatelessWidget {
  const CustomCourseDetailsBodyCourseInfoTexts({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "تاريخ النشر (${courseEntity.postedDate})",
          style: AppTextStyles(context)
              .regular10
              .copyWith(color: const Color(0xff818181)),
        ),
        Text(
          "الوصف:",
          style: AppTextStyles(context)
              .semiBold12
              .copyWith(color: const Color(0xff818181)),
        ),
        Text(
          courseEntity.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
          style: AppTextStyles(context)
              .regular10
              .copyWith(color: const Color(0xff818181)),
        ),
      ],
    );
  }
}
