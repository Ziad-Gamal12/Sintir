import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddQuestionExplainationImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddQuestionImage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionInputs.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';

/// The editing card for one exam question.
///
/// Its layout follows the card's own width: the two image pickers sit side by
/// side from [sideBySideMinWidth] up and stack below it, with tighter padding
/// on narrow cards. When the teacher tries to continue without marking a
/// correct answer here, the card turns red and, if it is the first such
/// question, scrolls into view.
class AddCourseExamAddQuestionListViewItem extends StatefulWidget {
  const AddCourseExamAddQuestionListViewItem({
    super.key,
    required this.coursetestquestionentity,
    required this.coursetestentity,
    required this.index,
  });

  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity coursetestentity;
  final int index;

  static const double sideBySideMinWidth = 520;

  @override
  State<AddCourseExamAddQuestionListViewItem> createState() =>
      _AddCourseExamAddQuestionListViewItemState();
}

class _AddCourseExamAddQuestionListViewItemState
    extends State<AddCourseExamAddQuestionListViewItem> {
  bool _flagged = false;

  CourseTestQuestionEntity get _question => widget.coursetestquestionentity;

  void _onMissingCorrectAnswer(
    BuildContext context,
    ExamQuestionsMissingCorrectAnswer state,
  ) {
    setState(() => _flagged = true);
    if (identical(state.questions.first, _question)) {
      Scrollable.ensureVisible(
        context,
        alignment: 0.05,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);

    // Built once per build() and reused by the BlocBuilder below, which then
    // only repaints the card's border when the correct answer changes.
    final content = LayoutBuilder(
      builder: (context, constraints) {
        final sideBySide =
            constraints.maxWidth >=
            AddCourseExamAddQuestionListViewItem.sideBySideMinWidth;
        final questionImage = AddCourseExamAddQuestionImage(
          coursetestquestionentity: _question,
        );
        final explanationImage = AddCourseExamAddQuestionExplainationImage(
          coursetestquestionentity: _question,
        );

        return Padding(
          padding: EdgeInsets.all(sideBySide ? 20 : 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ExamQuestionInputs(
                index: widget.index,
                coursetestquestionentity: _question,
                courseTestEntity: widget.coursetestentity,
                flagged: _flagged,
              ),
              const SizedBox(height: 12),
              Divider(height: 1, color: tokens.cardBorder),
              const SizedBox(height: 16),
              if (sideBySide)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(child: questionImage),
                    const SizedBox(width: 12),
                    Expanded(child: explanationImage),
                  ],
                )
              else ...[
                questionImage,
                const SizedBox(height: 12),
                explanationImage,
              ],
            ],
          ),
        );
      },
    );

    return Dismissible(
      key: ObjectKey(_question),
      onDismissed: (direction) => removeQuestionItem(context),
      direction: DismissDirection.horizontal,
      child: BlocConsumer<TestItemCubit, TestItemState>(
        listenWhen: (previous, current) =>
            current is ExamQuestionsMissingCorrectAnswer &&
            current.questions.any((q) => identical(q, _question)),
        listener: (context, state) => _onMissingCorrectAnswer(
          context,
          state as ExamQuestionsMissingCorrectAnswer,
        ),
        buildWhen: (previous, current) =>
            current is AddCourseSectionTestSolutionChanged ||
            current is AddCourseSectionTestSolutionRemoved,
        builder: (context, state) {
          final showError = _flagged && !_question.hasCorrectAnswer;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            decoration: BoxDecoration(
              color: tokens.cardBackground,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(
                color: showError ? tokens.dangerForeground : tokens.cardBorder,
              ),
              boxShadow: [
                BoxShadow(
                  color: tokens.cardShadow,
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: content,
          );
        },
      ),
    );
  }

  void removeQuestionItem(BuildContext context) {
    context.read<TestItemCubit>().removeQuestion(
      question: _question,
      coursetestentity: widget.coursetestentity,
    );
  }
}
