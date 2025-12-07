import 'package:flutter/material.dart';

class CustomReviewQuestionSolutionIndicator extends StatelessWidget {
  const CustomReviewQuestionSolutionIndicator({
    super.key,
    required this.isCorrect,
  });

  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      width: 15,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        border:
            Border.all(color: isCorrect ? Colors.green : Colors.grey, width: 1),
      ),
      child: isCorrect
          ? const CircleAvatar(backgroundColor: Colors.green)
          : const SizedBox(),
    );
  }
}
