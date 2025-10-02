import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/constant.dart';

class CustomReviewQuestionSolutionListitem extends StatelessWidget {
  const CustomReviewQuestionSolutionListitem({
    super.key,
    required this.solution,
  });
  final Coursetestquestionsolutionentity solution;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 15,
          width: 15,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            border: Border.all(color: Colors.grey, width: 1),
          ),
          child: solution.isCorrect == true
              ? const CircleAvatar(
                  backgroundColor: KMainColor,
                )
              : const SizedBox(),
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          solution.answer,
          style: AppTextStyles(context).regular14.copyWith(color: Colors.black),
        ),
      ],
    );
  }
}
