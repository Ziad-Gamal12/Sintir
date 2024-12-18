import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';

class CoursetestquestionItem extends StatefulWidget {
  const CoursetestquestionItem(
      {super.key,
      required this.coursetestentity,
      required this.currentQuestionIndex,
      required this.answerChange,
      required this.selectedAnswer});
  final Coursetestentity coursetestentity;
  final int currentQuestionIndex;
  final ValueChanged<String?> answerChange;
  final String selectedAnswer;
  @override
  State<CoursetestquestionItem> createState() => _CoursetestquestionItemState();
}

class _CoursetestquestionItemState extends State<CoursetestquestionItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.currentQuestionIndex + 1}-  ${widget.coursetestentity.questions[widget.currentQuestionIndex].questionTitle}",
          style: AppTextStyles.semiBold16.copyWith(color: Colors.black),
          textAlign: TextAlign.right,
        ),
        const SizedBox(
          height: 10,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: widget
              .coursetestentity.questions[widget.currentQuestionIndex].solutions
              .asMap()
              .entries
              .map((e) {
            return Row(
              children: [
                CustomRadioWidget(
                    value: e.value.answer,
                    groupValue: widget.selectedAnswer,
                    onchange: widget.answerChange),
                const SizedBox(
                  width: 10,
                ),
                Text(widget
                    .coursetestentity
                    .questions[widget.currentQuestionIndex]
                    .solutions[e.key]
                    .answer)
              ],
            );
          }).toList(),
        ),
      ],
    );
  }
}
