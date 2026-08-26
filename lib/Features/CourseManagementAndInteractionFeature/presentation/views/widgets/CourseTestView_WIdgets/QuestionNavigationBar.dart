import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseTestView_WIdgets/CourseTestQuestionsNavigation.dart';

class QuestionNavigationBar extends StatelessWidget {
  const QuestionNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onSelect,
  });

  final int currentIndex;
  final ValueChanged<int> onSelect;

  @override
  Widget build(BuildContext context) {
    return Coursetestquestionsnavigation(
      currentQuestionIndex: currentIndex,
      selectQuestionAction: onSelect,
    );
  }
}
