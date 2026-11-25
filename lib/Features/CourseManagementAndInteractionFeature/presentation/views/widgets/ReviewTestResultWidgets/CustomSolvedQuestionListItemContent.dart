import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolutionStateWidget.dart';
import 'package:sintir/locale_keys.dart';

/// The answers, plus the question image when there is one: beside the
/// answers on a wide card, above them on a compact one.
class CustomSolvedQuestionListItemContent extends StatelessWidget {
  const CustomSolvedQuestionListItemContent({
    super.key,
    required this.examResultSolvedQuestionEntity,
    required this.isWide,
  });

  final ExamResultSolvedQuestionEntity examResultSolvedQuestionEntity;
  final bool isWide;

  static const double _stackedImageHeight = 200;

  @override
  Widget build(BuildContext context) {
    final question = examResultSolvedQuestionEntity.question;
    final imageUrl = question.imageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    final rightAnswer = question.solutions
        .where((solution) => solution.isCorrect)
        .map((solution) => solution.answer)
        .firstOrNull;

    final answers = Customsolutionstatewidget(
      isCorrect: examResultSolvedQuestionEntity.isCorrect,
      rightAnswer: rightAnswer ?? LocaleKeys.noSolution,
      selectedAnswer: question.selectedSolution ?? '',
    );

    if (!hasImage) return answers;

    if (isWide) {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(flex: 3, child: answers),
          const SizedBox(width: 16),
          Expanded(
            flex: 2,
            child: AspectRatio(
              aspectRatio: 4 / 3,
              child: _QuestionImage(imageUrl: imageUrl),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        SizedBox(
          height: _stackedImageHeight,
          child: _QuestionImage(imageUrl: imageUrl),
        ),
        const SizedBox(height: 12),
        answers,
      ],
    );
  }
}

/// Shown whole (`contain`) on a tinted backdrop, so diagrams and text in the
/// image are never cropped by the box shape.
class _QuestionImage extends StatelessWidget {
  const _QuestionImage({required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: ColoredBox(
        color: Theme.of(
          context,
        ).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
        child: CustomCachedNetworkImage(
          imageUrl: imageUrl,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
