import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewQuestionSolutionListitem.dart';

class Customreviewquestionsolutionlist extends StatelessWidget {
  const Customreviewquestionsolutionlist({super.key, required this.solutions});
  final List<CourseTestQuestionSolutionEntity> solutions;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      spacing: 8,
      children: [
        for (final solution in solutions)
          CustomReviewQuestionSolutionListItem(
            key: ObjectKey(solution),
            solution: solution,
          ),
      ],
    );
  }
}
