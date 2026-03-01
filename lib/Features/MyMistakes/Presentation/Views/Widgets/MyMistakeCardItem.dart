import 'package:flutter/material.dart';
import 'package:localingo/app_localizations.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemContent.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemHeader.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItemQuestionTitle%20.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ShowHideSolutionButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/SolutionImageOverlay.dart';

class MyMistakeCardItem extends StatefulWidget {
  const MyMistakeCardItem({
    super.key,
    required this.mistakeEntity,
    required this.index,
    required this.length,
  });

  final QuestionMistakeEntity mistakeEntity;
  final int index;
  final int length;

  @override
  State<MyMistakeCardItem> createState() => _MyMistakeCardItemState();
}

class _MyMistakeCardItemState extends State<MyMistakeCardItem> {
  bool isSolutionVisible = false;

  @override
  Widget build(BuildContext context) {
    final hasSolutionImage =
        widget.mistakeEntity.question.question.imageUrl?.isNotEmpty;

    final borderColor = widget.mistakeEntity.question.isCorrect
        ? Colors.green.shade400
        : Colors.red.shade400;
    final backgroundColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[900]
        : Colors.grey.shade50;
    String locale = AppLocalizations.of(context).locale.languageCode;

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
                    isCorrect: widget.mistakeEntity.question.isCorrect,
                  ),
                  const SizedBox(height: 14),
                  CustomSolvedQuestionListItemQuestionTitle(
                    questionTitle:
                        widget.mistakeEntity.question.question.questionTitle ??
                            '_',
                  ),
                  const SizedBox(height: 12),
                  Expanded(
                    child: CustomSolvedQuestionListItemContent(
                      examResultSolvedQuestionEntity:
                          widget.mistakeEntity.question,
                    ),
                  ),
                ],
              ),
            ),
            if (isSolutionVisible)
              Positioned.fill(
                child: SolutionImageOverlay(
                  imageUrl: widget.mistakeEntity.question.question.imageUrl!,
                ),
              ),
            if (hasSolutionImage ?? false)
              Positioned(
                top: 8,
                right: locale == 'ar' ? null : 8,
                left: locale == 'ar' ? 8 : null,
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
