import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomReviewExamQuestionsHeader extends StatelessWidget {
  const CustomReviewExamQuestionsHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "مراجعه اسئلة الأمتحان",
          style: AppTextStyles(context).semiBold20,
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
