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
    final theme = Theme.of(context);
    final questionBgColor = theme.colorScheme.surfaceContainerHighest;
    final statusBgColor =
        isCorrect ? Colors.green.shade400 : Colors.red.shade400;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: questionBgColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            "${LocaleKeys.questionNumber} ${index + 1}/$length",
            style: AppTextStyles(context)
                .semiBold16
                .copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
        ),
        const SizedBox(height: 6),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            color: statusBgColor,
            borderRadius: BorderRadius.circular(10),
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
