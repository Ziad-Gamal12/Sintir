import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class AddCourseSectionExamListviewHeader extends StatelessWidget {
  const AddCourseSectionExamListviewHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const SizedBox(
        height: 20,
      ),
      Text(
        LocaleKeys.examQuestions,
        style: AppTextStyles(context).semiBold20,
      ),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
