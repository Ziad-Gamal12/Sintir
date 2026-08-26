import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestquestionItem.dart';

class TestQuestionDisplay extends StatelessWidget {
  const TestQuestionDisplay({
    super.key,
    required this.test,
    required this.currentQuestionIndex,
    required this.onAnswerSelected,
  });

  final CourseTestEntity test;
  final int currentQuestionIndex;
  final ValueChanged<String?> onAnswerSelected;

  @override
  Widget build(BuildContext context) {
    final question = test.questions[currentQuestionIndex];
    return CourseTestQuestionItem(
      currentQuestionIndex: currentQuestionIndex,
      answerChange: onAnswerSelected,
      selectedAnswer: question.selectedSolution ?? "",
    );
  }
}
