import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/QuestionTitleWidget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/question_image_widget.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestView_WIdgets/question_options_list.dart';

class CourseTestQuestionItem extends StatelessWidget {
  const CourseTestQuestionItem({
    super.key,
    required this.currentQuestionIndex,
    required this.answerChange,
    required this.selectedAnswer,
  });

  final int currentQuestionIndex;
  final ValueChanged<String?> answerChange;
  final String selectedAnswer;

  @override
  Widget build(BuildContext context) {
    final CourseTestEntity test =
        context.read<CourseExamViewNavigationsRequirmentsEntity>().test;
    final question = test.questions[currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionTitleWidget(
          index: currentQuestionIndex,
          title: question.questionTitle ?? "",
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: QuestionOptionsList(
                solutions: question.solutions,
                selectedAnswer: selectedAnswer,
                onChanged: answerChange,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: QuestionImageWidget(imageUrl: question.imageUrl),
            ),
          ],
        ),
      ],
    );
  }
}
