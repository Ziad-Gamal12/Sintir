import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CustomCountWidget.dart';
import 'package:sintir/constant.dart';

class Coursetestquestionsnavigation extends StatefulWidget {
  const Coursetestquestionsnavigation({
    super.key,
    required this.selectQuestionAction,
    required this.currentQuestionIndex,
  });
  final ValueChanged<int> selectQuestionAction;
  final int currentQuestionIndex;

  @override
  State<Coursetestquestionsnavigation> createState() =>
      _CoursetestquestionsnavigationState();
}

class _CoursetestquestionsnavigationState
    extends State<Coursetestquestionsnavigation> {
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    CourseTestEntity test =
        context.read<Coursetestviewnavigationsrequirmentsentity>().test;
    return Wrap(
      children: test.questions.asMap().entries.map((e) {
        return InkWell(
          onTap: () {
            currentQuestionIndex = e.key;
            widget.selectQuestionAction(currentQuestionIndex);
            e.value.isOpened = true;
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
              child: CustomCountWidget(
                countColor: getCountColor(e.value),
                count: "${e.key + 1}",
                countTextColor: getTextColor(e.value),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Color getCountColor(CourseTestQuestionEntity question) {
    if (question.isOpened &&
        (question.selectedSolution == null ||
            question.selectedSolution == "")) {
      return Colors.red.shade500;
    } else if (question.isOpened &&
        (question.selectedSolution != null &&
            question.selectedSolution != "")) {
      return KMainColor;
    } else {
      return Colors.grey.shade300;
    }
  }

  Color getTextColor(CourseTestQuestionEntity question) {
    if (question.isOpened &&
        (question.selectedSolution == null ||
            question.selectedSolution == "")) {
      return Colors.white;
    } else if (question.isOpened &&
        (question.selectedSolution != null &&
            question.selectedSolution != "")) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
