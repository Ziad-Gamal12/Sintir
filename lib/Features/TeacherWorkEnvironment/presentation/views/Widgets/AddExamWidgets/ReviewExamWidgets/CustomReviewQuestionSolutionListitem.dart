import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/LineAlignedControl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';

import 'CustomReviewQuestionSolutionIndicator.dart';

/// One answer on the review step; the correct one is tinted green. Long
/// answers wrap with the indicator and check mark kept on the first line.
class CustomReviewQuestionSolutionListItem extends StatelessWidget {
  const CustomReviewQuestionSolutionListItem({
    super.key,
    required this.solution,
  });

  final CourseTestQuestionSolutionEntity solution;

  @override
  Widget build(BuildContext context) {
    final isCorrect = solution.isCorrect;
    final theme = Theme.of(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final correctColor = tokens.successForeground;

    final textStyle = AppTextStyles(context).regular14.copyWith(
      color: isCorrect ? correctColor : theme.textTheme.bodyLarge?.color,
    );
    final lineStyle = DefaultTextStyle.of(context).style.merge(textStyle);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: isCorrect ? tokens.successBackground : Colors.transparent,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: isCorrect ? tokens.successBorder : tokens.cardBorder,
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          LineAlignedControl(
            style: lineStyle,
            child: CustomReviewQuestionSolutionIndicator(isCorrect: isCorrect),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(solution.answer, style: textStyle)),
          if (isCorrect) ...[
            const SizedBox(width: 8),
            LineAlignedControl(
              style: lineStyle,
              child: Icon(Icons.check_rounded, color: correctColor, size: 20),
            ),
          ],
        ],
      ),
    );
  }
}
