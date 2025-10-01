import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomSolvedQuestionListItemHeader extends StatelessWidget {
  const CustomSolvedQuestionListItemHeader({
    super.key,
    required this.index,
    required this.length,
    required this.isCorrect,
  });

  final int index;
  final int length;
  final bool isCorrect;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "السؤال رقم ${index + 1}/ $length",
            style:
                AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: isCorrect ? Colors.green : Colors.red,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            isCorrect ? "اجابة صحيحة" : "اجابة خاطئة",
            style:
                AppTextStyles(context).semiBold16.copyWith(color: Colors.white),
          ),
        ),
      ],
    );
  }
}
