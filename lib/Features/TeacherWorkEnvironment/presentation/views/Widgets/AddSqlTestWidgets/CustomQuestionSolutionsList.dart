// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSQlAddSolutionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class CustomQuestionSolutionsList extends StatefulWidget {
  const CustomQuestionSolutionsList({
    super.key,
    required this.coursetestentity,
    required this.question,
  });
  final Coursetestentity coursetestentity;
  final Coursetestquestionentity question;
  @override
  State<CustomQuestionSolutionsList> createState() =>
      _CustomQuestionSolutionsListState();
}

class _CustomQuestionSolutionsListState
    extends State<CustomQuestionSolutionsList> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseSectionCubit, AddCourseSectionState>(
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
                        context
                            .read<AddCourseSectionCubit>()
                            .changeSelectedSolution(
                                question: widget.question, index: e.key);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<AddCourseSectionCubit>().removeSolutin(
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
