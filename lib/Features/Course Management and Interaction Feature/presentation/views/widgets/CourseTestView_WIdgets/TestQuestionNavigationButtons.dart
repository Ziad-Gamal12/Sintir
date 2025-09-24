import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/constant.dart';

class TestQuestionNavigationButtons extends StatelessWidget {
  const TestQuestionNavigationButtons({
    super.key,
    required this.nextQuestion,
    required this.previousQuestion,
  });
  final VoidCallback nextQuestion;
  final VoidCallback previousQuestion;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Custombutton(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(8),
                bottomRight: Radius.circular(8),
              ),
              text: "التالى",
              color: KMainColor,
              textColor: Colors.white,
              onPressed: nextQuestion),
        ),
        Expanded(
          child: Custombutton(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
              text: "السابق",
              color: Colors.white,
              textColor: Colors.black,
              onPressed: previousQuestion),
        )
      ],
    );
  }
}
