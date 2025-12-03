import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemContent.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemQuestionTitle%20.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ShowHideSolutionButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/SolutionImageOverlay.dart';

class CustomSolvedQuestionListItem extends StatefulWidget {
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
  State<CustomSolvedQuestionListItem> createState() =>
      _CustomSolvedQuestionListItemState();
}

class _CustomSolvedQuestionListItemState
    extends State<CustomSolvedQuestionListItem> {
  bool isSolutionVisible = false;

  @override
  Widget build(BuildContext context) {
    final hasSolutionImage =
        widget.examResultSolvedQuestionEntity.solutionImageUrl.isNotEmpty;

    // Colors based on correctness
    final borderColor = widget.examResultSolvedQuestionEntity.isCorrect
        ? Colors.green.shade400
        : Colors.red.shade400;
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900]
        : Colors.grey.shade50;

    return AspectRatio(
      aspectRatio: 2 / 1.4,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: backgroundColor,
          border: Border.all(color: borderColor, width: 1.2),
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Stack(
          children: [
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomSolvedQuestionListItemHeader(
                    index: widget.index,
                    length: widget.length,
                    isCorrect: widget.examResultSolvedQuestionEntity.isCorrect,
                  ),
                  const SizedBox(height: 14),
                  CustomSolvedQuestionListItemQuestionTitle(
                    questionTitle:
                        widget.examResultSolvedQuestionEntity.questionTitle,
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: CustomSolvedQuestionListItemContent(
                      examResultSolvedQuestionEntity:
                          widget.examResultSolvedQuestionEntity,
                    ),
                  ),
                ],
              ),
            ),
            if (isSolutionVisible)
              Positioned.fill(
                child: SolutionImageOverlay(
                  imageUrl:
                      widget.examResultSolvedQuestionEntity.solutionImageUrl,
                ),
              ),
            if (hasSolutionImage)
              Positioned(
                top: 8,
                right: 8,
                child: ShowHideSolutionButton(
                  isVisible: isSolutionVisible,
                  onTap: () {
                    setState(() {
                      isSolutionVisible = !isSolutionVisible;
                    });
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
