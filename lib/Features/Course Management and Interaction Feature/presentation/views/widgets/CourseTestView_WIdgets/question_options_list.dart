import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/question_option_tile.dart';

class QuestionOptionsList extends StatelessWidget {
  const QuestionOptionsList({
    super.key,
    required this.solutions,
    required this.selectedAnswer,
    required this.onChanged,
  });

  final List<CourseTestQuestionSolutionEntity> solutions;
  final String selectedAnswer;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(solutions.length, (index) {
        final solution = solutions[index];
        return QuestionOptionTile(
          value: solution.answer,
          groupValue: selectedAnswer,
          onChanged: onChanged,
        );
      }),
    );
  }
}
