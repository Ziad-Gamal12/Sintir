import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomAddCourseSectionExamNameAndDurationHeader extends StatelessWidget {
  const CustomAddCourseSectionExamNameAndDurationHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(
        LocaleKeys.examDetails,
        style: AppTextStyles(context).semiBold20.copyWith(
              color: Theme.of(context).textTheme.titleLarge?.color,
            ),
      ),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
