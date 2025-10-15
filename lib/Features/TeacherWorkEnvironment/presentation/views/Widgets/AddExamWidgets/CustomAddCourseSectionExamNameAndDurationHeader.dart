import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomAddCourseSectionExamNameAndDurationHeader extends StatelessWidget {
  const CustomAddCourseSectionExamNameAndDurationHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        "تفاصيل الامتحان",
        style: AppTextStyles(context).semiBold20,
      ),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
