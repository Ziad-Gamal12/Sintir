import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseBottomSheetCourseDetailsDescription extends StatelessWidget {
  const CourseBottomSheetCourseDetailsDescription({
    super.key,
    required this.description,
  });

  final String description;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(LocaleKeys.descriptionLabel,
            style: AppTextStyles(context).semiBold20),
        const SizedBox(
          height: 12,
        ),
        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style:
              AppTextStyles(context).regular14.copyWith(color: Colors.black87),
        ),
      ],
    );
  }
}
