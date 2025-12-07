import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

import 'CustomReviewQuestionSolutionIndicator.dart';

class CustomReviewQuestionSolutionListItem extends StatelessWidget {
  const CustomReviewQuestionSolutionListItem({
    super.key,
    required this.solution,
  });

  final CourseTestQuestionSolutionEntity solution;

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = solution.isCorrect;
    final ThemeData theme = Theme.of(context);

    final Color defaultTextColor = theme.textTheme.bodyLarge!.color!;
    final Color correctColor = Colors.green.shade600;
    final Color correctBackgroundColor = isCorrect
        ? Colors.green
            .withOpacity(theme.brightness == Brightness.dark ? 0.2 : 0.1)
        : Colors.transparent;
    final Color correctBorderColor = isCorrect
        ? correctColor
            .withOpacity(theme.brightness == Brightness.dark ? 0.5 : 1.0)
        : Colors.transparent;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        // Use theme-aware success background color
        color: correctBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          // Use theme-aware border color
          color: correctBorderColor,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // CustomReviewQuestionSolutionIndicator needs to be theme-aware internally
          CustomReviewQuestionSolutionIndicator(isCorrect: isCorrect),
          const SizedBox(width: 10),
          Text(
            solution.answer,
            style: AppTextStyles(context).regular14.copyWith(
                  // Use green for correct, otherwise use defaultTextColor
                  color: isCorrect ? correctColor : defaultTextColor,
                ),
          ),
          const Spacer(),
          if (isCorrect)
            Icon(
              Icons.check,
              // Use the theme-aware correct color for the icon
              color: correctColor,
            ),
        ],
      ),
    );
  }
}
