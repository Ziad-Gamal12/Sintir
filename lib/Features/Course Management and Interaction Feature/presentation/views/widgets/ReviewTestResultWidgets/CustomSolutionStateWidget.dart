import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolutionStateRowWidget.dart';

class Customsolutionstatewidget extends StatelessWidget {
  const Customsolutionstatewidget(
      {super.key,
      required this.rightAnswer,
      required this.selectedAnswer,
      required this.isCorrect});
  final String rightAnswer, selectedAnswer;
  final bool isCorrect;
  @override
  Widget build(BuildContext context) {
    if (isCorrect) {
      return CustomSolutionStateRowWidget(
          isCorrect: isCorrect, title: selectedAnswer);
    } else {
      return Column(
        children: [
          CustomSolutionStateRowWidget(isCorrect: true, title: rightAnswer),
          const SizedBox(
            height: 20,
          ),
          CustomSolutionStateRowWidget(isCorrect: false, title: selectedAnswer),
        ],
      );
    }
  }
}
