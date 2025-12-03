import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddcourseExamQuestionItemTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomQuestionSolutionsList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionInputsAddNewSoluotionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionInputsQuestionHeader.dart';

class ExamQuestionInputs extends StatelessWidget {
  const ExamQuestionInputs({
    super.key,
    required this.courseTestEntity,
    required this.coursetestquestionentity,
    required this.index,
  });
  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity courseTestEntity;
  final int index;
  @override
  Widget build(BuildContext context) {
    // Fetch the theme's card color for the container background
    final Color containerColor = Theme.of(context).cardColor;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        // Use theme-aware color instead of hardcoded Colors.white
        color: containerColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 10,
          ),
          ExamQuestionInputsQuestionHeader(
              index: index, totalQuestions: courseTestEntity.questions.length),
          const SizedBox(
            height: 20,
          ),
          // Note: AddcourseExamQuestionItemTextField needs to be theme-aware internally (text/border color)
          AddcourseExamQuestionItemTextField(
            coursetestquestionentity: coursetestquestionentity,
          ),
          const SizedBox(
            height: 10,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Note: CustomQuestionSolutionsList needs to be theme-aware internally
              CustomQuestionSolutionsList(
                question: coursetestquestionentity,
                coursetestentity: courseTestEntity,
              ),
              const SizedBox(
                height: 10,
              ),
              // Note: ExamQuestionInputsAddNewSoluotionButton needs to be theme-aware internally
              ExamQuestionInputsAddNewSoluotionButton(
                  coursetestquestionentity: coursetestquestionentity)
            ],
          )
        ],
      ),
    );
  }
}
