import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CustomSolvedQuestionListItemQuestionTitle extends StatelessWidget {
  const CustomSolvedQuestionListItemQuestionTitle({
    super.key,
    required this.questionTitle,
    this.isWide = false,
  });

  final String questionTitle;

  /// Tablet-width card: a larger title, since there is room for it.
  final bool isWide;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color textColor = theme.textTheme.bodyLarge!.color!;
    final styles = AppTextStyles(context);

    return Text(
      questionTitle.isEmpty ? LocaleKeys.questionNotFound : questionTitle,
      style: (isWide ? styles.semiBold20 : styles.semiBold16).copyWith(
        color: textColor,
        height: 1.4,
      ),
    );
  }
}
