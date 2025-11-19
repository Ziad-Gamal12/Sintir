import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

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
        Text("الوصف", style: AppTextStyles(context).semiBold16),
        const SizedBox(
          height: 10,
        ),
        Text(
          description,
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(context).regular10.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
