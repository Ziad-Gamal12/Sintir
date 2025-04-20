import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolutionStateWidget.dart';

class CustomSolvedQuestionListItem extends StatelessWidget {
  const CustomSolvedQuestionListItem({
    super.key,
    required this.examResultSolvedQuestionEntity,
  });

  final ExamResultSolvedQuestionEntity examResultSolvedQuestionEntity;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2 / 1.2,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
        decoration: BoxDecoration(
          color: examResultSolvedQuestionEntity.isCorrect
              ? Colors.green.shade100
              : Colors.red.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              examResultSolvedQuestionEntity.questionTitle,
              style: AppTextStyles.semiBold20.copyWith(color: Colors.black),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Customsolutionstatewidget(
                      isCorrect: examResultSolvedQuestionEntity.isCorrect,
                      rightAnswer: examResultSolvedQuestionEntity.rightAnswer,
                      selectedAnswer:
                          examResultSolvedQuestionEntity.selectedAnswer,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Visibility(
                    visible: examResultSolvedQuestionEntity.imageUrl.isNotEmpty,
                    child: Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: AspectRatio(
                          aspectRatio: 1,
                          child: CachedNetworkImage(
                            imageUrl: examResultSolvedQuestionEntity.imageUrl,
                            fit: BoxFit.cover,
                            placeholder: (context, url) => const Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                const Icon(Icons.error),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
