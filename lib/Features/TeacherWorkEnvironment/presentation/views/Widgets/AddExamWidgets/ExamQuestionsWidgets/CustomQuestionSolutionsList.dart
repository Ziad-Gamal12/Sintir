import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/CustomQuestionSolutionsListCustomSolutionItem.dart';

/// The answers of one question, as a radio group whose selected answer is
/// the question's correct answer.
class CustomQuestionSolutionsList extends StatelessWidget {
  const CustomQuestionSolutionsList({
    super.key,
    required this.coursetestentity,
    required this.question,
  });

  final CourseTestEntity coursetestentity;
  final CourseTestQuestionEntity question;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      buildWhen: (previous, current) {
        return current is AddCourseSectionTestSolutionAdded ||
            current is AddCourseSectionTestSolutionRemoved ||
            current is AddCourseSectionTestSolutionChanged;
      },
      builder: (context, state) {
        return RadioGroup<String>(
          groupValue: question.correctSolution?.id,
          onChanged: (id) {
            final index = question.solutions.indexWhere((s) => s.id == id);
            if (index == -1) return;
            context.read<TestItemCubit>().changeSelectedSolution(
              question: question,
              index: index,
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            spacing: 8,
            children: [
              for (final solution in question.solutions)
                CustomQuestionSolutionsListCustomSolutionItem(
                  key: ObjectKey(solution),
                  solution: solution,
                  question: question,
                  coursetestentity: coursetestentity,
                ),
            ],
          ),
        );
      },
    );
  }
}
