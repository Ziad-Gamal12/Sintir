import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionSolutionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseExamAddSolutionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomRemoveSolutionItem.dart';

class CustomQuestionSolutionsListCustomSolutionItem extends StatelessWidget {
  const CustomQuestionSolutionsListCustomSolutionItem({
    super.key,
    required this.e,
    required this.question,
    required this.coursetestentity,
  });
  final CourseTestQuestionEntity question;
  final CourseTestEntity coursetestentity;

  final MapEntry<int, Coursetestquestionsolutionentity> e;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      buildWhen: (previous, current) {
        if (current is AddCourseSectionTestSolutionChanged) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: AddCourseExamAddSolutionItem(
                coursetestquestionsolutionentity: e.value,
                groupValue: getGroupValue(),
                onChange: (value) {
                  context
                      .read<TestItemCubit>()
                      .changeSelectedSolution(question: question, index: e.key);
                },
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            CustomRemoveSolutionItem(
                coursetestentity: coursetestentity, e: e, question: question)
          ],
        );
      },
    );
  }

  String getGroupValue() {
    return question.solutions
        .firstWhere((s) => s.isCorrect,
            orElse: () =>
                Coursetestquestionsolutionentity(answer: "", isCorrect: false))
        .id
        .toString();
  }
}
