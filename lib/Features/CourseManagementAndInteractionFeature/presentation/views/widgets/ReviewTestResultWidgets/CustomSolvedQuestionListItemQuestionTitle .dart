import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomSolvedQuestionListItemQuestionTitle extends StatelessWidget {
  const CustomSolvedQuestionListItemQuestionTitle({
    super.key,
    required this.questionTitle,
  });

  final String questionTitle;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = theme.textTheme.bodyLarge!.color!;

    return Text(
      questionTitle.isEmpty ? LocaleKeys.questionNotFound : questionTitle,
      style: AppTextStyles(context).semiBold20.copyWith(
            color: textColor,
          ),
    );
  }
}
