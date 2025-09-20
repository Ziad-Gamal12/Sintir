// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSQlAddSolutionItem.dart';

class CustomQuestionSolutionsList extends StatefulWidget {
  const CustomQuestionSolutionsList({
    super.key,
    required this.coursetestentity,
    required this.question,
  });
  final CourseTestEntity coursetestentity;
  final CourseTestQuestionEntity question;
  @override
  State<CustomQuestionSolutionsList> createState() =>
      _CustomQuestionSolutionsListState();
}

class _CustomQuestionSolutionsListState
    extends State<CustomQuestionSolutionsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: widget.question.solutions.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: AddCourseSQlAddSolutionItem(
                      coursetestquestionsolutionentity: e.value,
                      groupValue: widget.question.solutions
                          .indexWhere((s) => s.isCorrect)
                          .toString(),
                      onChange: (value) {
                        context.read<TestItemCubit>().changeSelectedSolution(
                            question: widget.question, index: e.key);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<TestItemCubit>().removeSolutin(
                          coursetestentity: widget.coursetestentity,
                          solution: e.value,
                          question: widget.question);
                    },
                    icon: const Icon(
                      FontAwesomeIcons.trashCan,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
