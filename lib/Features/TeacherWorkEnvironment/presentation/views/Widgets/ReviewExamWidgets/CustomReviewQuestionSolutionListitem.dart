import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

import 'CustomReviewQuestionSolutionIndicator.dart';

class CustomReviewQuestionSolutionListItem extends StatelessWidget {
  const CustomReviewQuestionSolutionListItem({
    super.key,
    required this.solution,
  });

  final Coursetestquestionsolutionentity solution;

  @override
  Widget build(BuildContext context) {
    final bool isCorrect = solution.isCorrect;

    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: isCorrect ? Colors.green.shade50 : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: isCorrect ? Colors.green : Colors.transparent,
          width: 1,
        ),
      ),
      child: Row(
        children: [
          CustomReviewQuestionSolutionIndicator(isCorrect: isCorrect),
          const SizedBox(width: 10),
          Text(
            solution.answer,
            style: AppTextStyles(context).regular14.copyWith(
                  color: isCorrect ? Colors.green : Colors.black,
                ),
          ),
          const Spacer(),
          if (isCorrect) const Icon(Icons.check, color: Colors.green),
        ],
      ),
    );
  }
}
