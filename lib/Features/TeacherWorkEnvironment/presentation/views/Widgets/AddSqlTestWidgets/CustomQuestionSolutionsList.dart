// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSQlAddSolutionItem.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/AddCourseSectionCubit/AddCourseSectionCubit.dart';

class CustomQuestionSolutionsList extends StatefulWidget {
  const CustomQuestionSolutionsList({
    super.key,
  });

  @override
  State<CustomQuestionSolutionsList> createState() =>
      _CustomQuestionSolutionsListState();
}

class _CustomQuestionSolutionsListState
    extends State<CustomQuestionSolutionsList> {
  String selectedValue = "-1";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddCourseSectionCubit, AddCourseSectionState>(
      builder: (context, state) {
        Coursetestquestionentity question =
            context.read<Coursetestquestionentity>();
        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: question.solutions.asMap().entries.map((e) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 5),
              child: Row(
                children: [
                  Expanded(
                    child: AddCourseSQlAddSolutionItem(
                      coursetestquestionsolutionentity: e.value,
                      groupValue: selectedValue,
                      onChange: (value) {
                        setState(() {
                          selectedValue = value!;
                        });
                        context
                            .read<AddCourseSectionCubit>()
                            .changeSelectedSolution(
                                question: question, index: e.key);
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  IconButton(
                    onPressed: () {
                      context.read<AddCourseSectionCubit>().removeSolutin(
                          solution: e.value,
                          question: context.read<Coursetestquestionentity>());
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
