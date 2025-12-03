import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class QuestionTitleWidget extends StatelessWidget {
  const QuestionTitleWidget({
    super.key,
    required this.index,
    required this.title,
  });

  final int index;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      '${index + 1}- $title',
      style: AppTextStyles(context).semiBold16,
      textAlign: TextAlign.right,
    );
  }
}
