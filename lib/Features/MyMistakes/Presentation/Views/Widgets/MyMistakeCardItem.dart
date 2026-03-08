import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

import 'MistakeCardFooter.dart';
import 'MistakeCardHeader.dart';
import 'MistakeSolutionReview.dart';

class MyMistakeCardItem extends StatelessWidget {
  final QuestionMistakeEntity mistake;
  const MyMistakeCardItem({super.key, required this.mistake});

  @override
  Widget build(BuildContext context) {
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final String correctAnswer = mistake.question.question.solutions.isNotEmpty
        ? mistake.question.question.solutions
            .firstWhere((s) => s.isCorrect,
                orElse: () => mistake.question.question.solutions.first)
            .answer
        : LocaleKeys.noSolution; // Localized fallback

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.white.withOpacity(0.05) : Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: isDarkMode ? Colors.white10 : Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MistakeCardHeader(
            subject: mistake.courseSubject,
            status: mistake.progress.status,
          ),
          const SizedBox(height: 16),
          Text(
            mistake.question.question.questionTitle ?? LocaleKeys.noTitle,
            style: AppTextStyles(context).bold16,
          ),
          const SizedBox(height: 16),
          MistakeSolutionReview(
            selectedAnswer: mistake.question.question.selectedSolution ??
                LocaleKeys.notSolved,
            correctAnswer: correctAnswer,
          ),
          const SizedBox(height: 16),
          const Divider(height: 1, thickness: 0.5),
          const SizedBox(height: 16),
          MistakeCardFooter(
            wrongCount: mistake.progress.wrongCount,
            correctStreak: mistake.progress.correctStreak,
          ),
        ],
      ),
    );
  }
}
