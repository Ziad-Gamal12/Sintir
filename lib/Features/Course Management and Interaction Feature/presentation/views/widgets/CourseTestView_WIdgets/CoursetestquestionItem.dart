import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomRadioWidget.dart';

class CoursetestquestionItem extends StatefulWidget {
  const CoursetestquestionItem(
      {super.key,
      required this.currentQuestionIndex,
      required this.answerChange,
      required this.selectedAnswer});
  final int currentQuestionIndex;
  final ValueChanged<String?> answerChange;
  final String selectedAnswer;
  @override
  State<CoursetestquestionItem> createState() => _CoursetestquestionItemState();
}

class _CoursetestquestionItemState extends State<CoursetestquestionItem> {
  @override
  Widget build(BuildContext context) {
    CourseTestEntity test =
        context.read<CourseExamViewNavigationsRequirmentsEntity>().test;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${widget.currentQuestionIndex + 1}-  ${test.questions[widget.currentQuestionIndex].questionTitle}",
          style:
              AppTextStyles(context).semiBold16.copyWith(color: Colors.black),
          textAlign: TextAlign.right,
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: test.questions[widget.currentQuestionIndex].solutions
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
                      Text(test.questions[widget.currentQuestionIndex]
                          .solutions[e.key].answer)
                    ],
                  );
                }).toList(),
              ),
            ),
            Expanded(
                child:
                    test.questions[widget.currentQuestionIndex].imageUrl != null
                        ? CachedNetworkImage(
                            imageUrl: test
                                .questions[widget.currentQuestionIndex]
                                .imageUrl!)
                        : const SizedBox())
          ],
        ),
      ],
    );
  }
}
