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
        ? Colors.green.withValues(
            alpha: theme.brightness == Brightness.dark ? 0.2 : 0.1,
          )
        : Colors.transparent;
    final Color correctBorderColor = isCorrect
        ? correctColor.withValues(
            alpha: theme.brightness == Brightness.dark ? 0.5 : 1.0,
          )
        : Colors.transparent;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: correctBackgroundColor,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: correctBorderColor, width: 1),
      ),
      child: Row(
        children: [
          CustomReviewQuestionSolutionIndicator(isCorrect: isCorrect),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              solution.answer,
              style: AppTextStyles(context).regular14.copyWith(
                color: isCorrect ? correctColor : defaultTextColor,
              ),
            ),
          ),
          const Spacer(),
          if (isCorrect) Icon(Icons.check, color: correctColor),
        ],
      ),
    );
  }
}
