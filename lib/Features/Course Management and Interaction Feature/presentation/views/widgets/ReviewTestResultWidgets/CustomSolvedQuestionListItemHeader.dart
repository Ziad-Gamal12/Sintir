import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomSolvedQuestionListItemHeader extends StatelessWidget {
  const CustomSolvedQuestionListItemHeader({
    super.key,
    required this.index,
    required this.length,
    required this.isCorrect,
  });

  final int index;
  final int length;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            " ${LocaleKeys.questionNumber} ${index + 1}/ $length",
            style:
                AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
          ),
        ),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCorrect ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isCorrect ? LocaleKeys.correctAnswer : LocaleKeys.wrongAnswer,
            style:
                AppTextStyles(context).semiBold16.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
