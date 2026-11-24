import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseTestView_WIdgets/QuestionTitleWidget.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseTestView_WIdgets/question_image_widget.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/CourseTestView_WIdgets/question_options_list.dart';

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

  static const double _stackedImageMaxHeight = 240;

  @override
  Widget build(BuildContext context) {
    final CourseTestEntity test = context
        .read<CourseExamViewNavigationsRequirmentsEntity>()
        .test;
    final question = test.questions[currentQuestionIndex];
    final imageUrl = question.imageUrl;
    final hasImage = imageUrl != null && imageUrl.isNotEmpty;

    final options = QuestionOptionsList(
      solutions: question.solutions,
      selectedAnswer: selectedAnswer,
      onChanged: answerChange,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        QuestionTitleWidget(
          index: currentQuestionIndex,
          title: question.questionTitle ?? "",
        ),
        const SizedBox(height: 16),
        if (!hasImage)
          options
        else
          LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth >= Breakpoints.medium) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(flex: 3, child: options),
                    const SizedBox(width: 16),
                    Expanded(
                      flex: 2,
                      child: QuestionImageWidget(imageUrl: imageUrl),
                    ),
                  ],
                );
              }

              // Compact: image on top, answers get the full width below it.
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: _stackedImageMaxHeight,
                      ),
                      child: QuestionImageWidget(imageUrl: imageUrl),
                    ),
                  ),
                  const SizedBox(height: 16),
                  options,
                ],
              );
            },
          ),
      ],
    );
  }
}
