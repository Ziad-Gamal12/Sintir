import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolutionStateWidget.dart';

class CustomSolvedQuestionListItemContent extends StatelessWidget {
  const CustomSolvedQuestionListItemContent({
    super.key,
    required this.examResultSolvedQuestionEntity,
  });

  final ExamResultSolvedQuestionEntity examResultSolvedQuestionEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Customsolutionstatewidget(
            isCorrect: examResultSolvedQuestionEntity.isCorrect,
            rightAnswer: examResultSolvedQuestionEntity.rightAnswer,
            selectedAnswer: examResultSolvedQuestionEntity.selectedAnswer,
          ),
        ),
        const SizedBox(width: 10),
        if (examResultSolvedQuestionEntity.imageUrl.isNotEmpty)
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: AspectRatio(
                aspectRatio: 1,
                child: CustomCachedNetworkImage(
                  imageUrl: examResultSolvedQuestionEntity.imageUrl,
                ),
              ),
            ),
          ),
      ],
    );
  }
}
