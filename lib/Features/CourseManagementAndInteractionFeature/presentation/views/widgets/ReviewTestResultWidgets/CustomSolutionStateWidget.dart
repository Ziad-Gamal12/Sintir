import 'package:flutter/material.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolutionStateRowWidget.dart';
import 'package:sintir/locale_keys.dart';

class Customsolutionstatewidget extends StatelessWidget {
  const Customsolutionstatewidget({
    super.key,
    required this.rightAnswer,
    required this.selectedAnswer,
    required this.isCorrect,
  });
  final String rightAnswer, selectedAnswer;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    if (isCorrect) {
      return CustomSolutionStateRowWidget(
        isCorrect: true,
        title: selectedAnswer.isEmpty ? rightAnswer : selectedAnswer,
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomSolutionStateRowWidget(isCorrect: true, title: rightAnswer),
        const SizedBox(height: 10),
        CustomSolutionStateRowWidget(
          isCorrect: false,
          title: selectedAnswer.isEmpty ? LocaleKeys.notSolved : selectedAnswer,
          isPlaceholder: selectedAnswer.isEmpty,
        ),
      ],
    );
  }
}
