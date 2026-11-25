import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddSolutionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/CustomRemoveSolutionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/LineAlignedControl.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// One answer row: the "correct answer" radio, the answer field, and a delete
/// button. The row turns green while it is the question's correct answer.
///
/// Must sit under the question's [RadioGroup].
class CustomQuestionSolutionsListCustomSolutionItem extends StatelessWidget {
  const CustomQuestionSolutionsListCustomSolutionItem({
    super.key,
    required this.solution,
    required this.question,
    required this.coursetestentity,
  });

  final CourseTestQuestionSolutionEntity solution;
  final CourseTestQuestionEntity question;
  final CourseTestEntity coursetestentity;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final fieldStyle = AddCourseExamAddSolutionItem.effectiveTextStyle(context);
    final isCorrect = solution.isCorrect;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: isCorrect ? tokens.successBackground : Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isCorrect ? tokens.successBorder : Colors.transparent,
        ),
      ),
      // Baseline alignment keeps the radio and delete button on the answer's
      // first line while long answers wrap and errors show below the field.
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.baseline,
        textBaseline: TextBaseline.alphabetic,
        children: [
          LineAlignedControl(
            style: fieldStyle,
            child: Tooltip(
              message: LocaleKeys.markCorrectAnswer,
              child: Radio<String>(
                value: solution.id,
                activeColor: tokens.successForeground,
              ),
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: AddCourseExamAddSolutionItem(
              coursetestquestionsolutionentity: solution,
            ),
          ),
          LineAlignedControl(
            style: fieldStyle,
            child: CustomRemoveSolutionItem(
              coursetestentity: coursetestentity,
              solution: solution,
              question: question,
            ),
          ),
        ],
      ),
    );
  }
}
