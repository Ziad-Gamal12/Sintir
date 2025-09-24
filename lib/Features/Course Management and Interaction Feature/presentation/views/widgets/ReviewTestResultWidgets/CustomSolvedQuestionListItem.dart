import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemContent.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemQuestionTitle%20.dart';

class CustomSolvedQuestionListItem extends StatelessWidget {
  const CustomSolvedQuestionListItem({
    super.key,
    required this.examResultSolvedQuestionEntity,
    required this.index,
    required this.length,
  });

  final ExamResultSolvedQuestionEntity examResultSolvedQuestionEntity;
  final int index;
  final int length;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1.4,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          border: Border.all(
            color: examResultSolvedQuestionEntity.isCorrect
                ? Colors.green
                : Colors.red,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomSolvedQuestionListItemHeader(
              index: index,
              length: length,
              isCorrect: examResultSolvedQuestionEntity.isCorrect,
            ),
            const SizedBox(height: 20),
            CustomSolvedQuestionListItemQuestionTitle(
              questionTitle: examResultSolvedQuestionEntity.questionTitle,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: CustomSolvedQuestionListItemContent(
                examResultSolvedQuestionEntity: examResultSolvedQuestionEntity,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
