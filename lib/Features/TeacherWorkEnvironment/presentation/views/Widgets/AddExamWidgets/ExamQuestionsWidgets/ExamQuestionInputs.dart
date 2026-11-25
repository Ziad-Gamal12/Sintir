import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddcourseExamQuestionItemTextField.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/CustomQuestionSolutionsList.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionCorrectAnswerStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionInputsAddNewSoluotionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/ExamQuestionInputsQuestionHeader.dart';

class ExamQuestionInputs extends StatelessWidget {
  const ExamQuestionInputs({
    super.key,
    required this.courseTestEntity,
    required this.coursetestquestionentity,
    required this.index,
    required this.flagged,
  });

  final CourseTestQuestionEntity coursetestquestionentity;
  final CourseTestEntity courseTestEntity;
  final int index;

  /// Whether the teacher already tried to continue while this question had
  /// no correct answer.
  final bool flagged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ExamQuestionInputsQuestionHeader(
          index: index,
          totalQuestions: courseTestEntity.questions.length,
          trailing: ExamQuestionCorrectAnswerStatus(
            question: coursetestquestionentity,
            flagged: flagged,
          ),
        ),
        const SizedBox(height: 16),
        AddcourseExamQuestionItemTextField(
          coursetestquestionentity: coursetestquestionentity,
        ),
        const SizedBox(height: 16),
        CustomQuestionSolutionsList(
          question: coursetestquestionentity,
          coursetestentity: courseTestEntity,
        ),
        const SizedBox(height: 4),
        Align(
          alignment: AlignmentDirectional.centerStart,
          child: ExamQuestionInputsAddNewSoluotionButton(
            coursetestquestionentity: coursetestquestionentity,
          ),
        ),
      ],
    );
  }
}
