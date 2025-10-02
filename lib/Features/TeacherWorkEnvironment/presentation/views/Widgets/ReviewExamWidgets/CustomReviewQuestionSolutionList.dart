import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewQuestionSolutionListitem.dart';

class Customreviewquestionsolutionlist extends StatelessWidget {
  const Customreviewquestionsolutionlist({super.key, required this.solutions});
  final List<Coursetestquestionsolutionentity> solutions;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomReviewQuestionSolutionListitem(
              solution: solutions[index],
            ),
          );
        },
        itemCount: solutions.length);
  }
}
