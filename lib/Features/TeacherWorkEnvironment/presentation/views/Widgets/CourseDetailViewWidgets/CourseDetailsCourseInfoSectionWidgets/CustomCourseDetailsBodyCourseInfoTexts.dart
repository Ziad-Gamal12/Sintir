import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomCourseDetailsBodyCourseInfoTexts extends StatelessWidget {
  const CustomCourseDetailsBodyCourseInfoTexts({
    super.key,
    required this.courseEntity,
  });

  final CourseEntity courseEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textColor = theme.textTheme.bodyMedium?.color ?? Colors.grey;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${LocaleKeys.createdDate} (${courseEntity.postedDate})",
          style: AppTextStyles(context)
              .regular10
              .copyWith(color: textColor.withOpacity(0.7)),
        ),
        Text(
          " ${LocaleKeys.descriptionLabel}:",
          style: AppTextStyles(context)
              .semiBold12
              .copyWith(color: textColor.withOpacity(0.8)),
        ),
        Text(
          courseEntity.description,
          overflow: TextOverflow.ellipsis,
          maxLines: 6,
          style: AppTextStyles(context)
              .regular10
              .copyWith(color: textColor.withOpacity(0.7)),
        ),
      ],
    );
  }
}
