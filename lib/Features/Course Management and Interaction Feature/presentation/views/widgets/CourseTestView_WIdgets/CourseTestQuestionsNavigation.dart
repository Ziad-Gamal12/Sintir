import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CoursetestviewBody.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/CustomCountWidget.dart';

class Coursetestquestionsnavigation extends StatefulWidget {
  const Coursetestquestionsnavigation({
    super.key,
    required this.widget,
    required this.selectQuestionAction,
  });
  final CoursetestviewBody widget;
  final ValueChanged<int> selectQuestionAction;

  @override
  State<Coursetestquestionsnavigation> createState() =>
      _CoursetestquestionsnavigationState();
}

class _CoursetestquestionsnavigationState
    extends State<Coursetestquestionsnavigation> {
  int currentQuestionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:
          widget.widget.coursetestentity.questions.asMap().entries.map((e) {
        return InkWell(
          onTap: () {
            currentQuestionIndex = e.key;
            widget.selectQuestionAction(currentQuestionIndex);
            setState(() {});
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: 40,
              child: CustomCountWidget(
                countColor: e.key == currentQuestionIndex
                    ? Colors.red.shade500
                    : Colors.grey.shade300,
                count: "${e.key + 1}",
                countTextColor:
                    e.key == currentQuestionIndex ? Colors.white : Colors.black,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
