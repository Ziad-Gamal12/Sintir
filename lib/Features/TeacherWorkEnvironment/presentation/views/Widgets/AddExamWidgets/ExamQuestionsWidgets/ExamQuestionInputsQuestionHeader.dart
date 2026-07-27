import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class ExamQuestionInputsQuestionHeader extends StatelessWidget {
  const ExamQuestionInputsQuestionHeader({
    super.key,
    required this.index,
    required this.totalQuestions,
  });

  final int index;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    // Get the current theme data
    final ThemeData theme = Theme.of(context);
    // Use the primary color for the main text, which adapts automatically (dark in light mode, light in dark mode)
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;

    // Use theme-aware colors for accents
    final Color iconColor = theme.primaryColor; // Often blue or a strong accent
    final Color totalCountColor =
        theme.colorScheme.error; // Often red or a contrasting color

    return Row(
      children: [
        FaIcon(FontAwesomeIcons.circleInfo, color: iconColor, size: 25),
        const SizedBox(
          width: 10,
        ),
        Text.rich(
          TextSpan(children: [
            TextSpan(
              text: " ${LocaleKeys.questionNumber}",
              style: AppTextStyles(context)
                  .semiBold16
                  .copyWith(color: primaryTextColor),
            ),
            TextSpan(
              text: "${index + 1}",
              style: AppTextStyles(context).bold16.copyWith(color: iconColor),
            ),
            TextSpan(
              text: " ${LocaleKeys.of} ",
              style: AppTextStyles(context)
                  .regular16
                  .copyWith(color: primaryTextColor),
            ),
            TextSpan(
              text: "$totalQuestions",
              style: AppTextStyles(context)
                  .bold16
                  .copyWith(color: totalCountColor),
            ),
          ]),
        ),
      ],
    );
  }
}
