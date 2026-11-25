import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionInputsQuestionHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ReviewExamWidgets/CustomReviewQuestionSolutionList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';

/// Read-only card for one question on the review step.
///
/// Without an image the answers use the full width. With one, the image sits
/// beside the answers from [sideBySideMinWidth] up and above them below it.
class CustomReviewExamQuestionListItem extends StatelessWidget {
  const CustomReviewExamQuestionListItem({
    super.key,
    required this.question,
    required this.totalQuestions,
    required this.index,
  });

  final CourseTestQuestionEntity question;
  final int totalQuestions;
  final int index;

  static const double sideBySideMinWidth = 560;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final title = question.questionTitle?.trim() ?? '';
    final image = question.imageFile;
    final answers = Customreviewquestionsolutionlist(
      solutions: question.solutions,
    );

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: tokens.cardBackground,
        border: Border.all(color: tokens.cardBorder),
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: tokens.cardShadow,
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final sideBySide = constraints.maxWidth >= sideBySideMinWidth;
          return Padding(
            padding: EdgeInsets.all(sideBySide ? 20 : 14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                ExamQuestionInputsQuestionHeader(
                  index: index,
                  totalQuestions: totalQuestions,
                ),
                if (title.isNotEmpty) ...[
                  const SizedBox(height: 12),
                  Text(
                    title,
                    style: AppTextStyles(context).semiBold16.copyWith(
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                if (image == null)
                  answers
                else if (sideBySide)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(flex: 3, child: answers),
                      const SizedBox(width: 16),
                      Expanded(
                        flex: 2,
                        child: CustomReviewQuestionImage(imageFile: image),
                      ),
                    ],
                  )
                else ...[
                  CustomReviewQuestionImage(imageFile: image),
                  const SizedBox(height: 12),
                  answers,
                ],
              ],
            ),
          );
        },
      ),
    );
  }
}
