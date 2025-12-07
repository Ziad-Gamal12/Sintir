import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseSectionExamListview.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseSectionExamListviewHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddQuestionButton.dart';
import 'package:sintir/constant.dart';

class CustomAddExamQuestionsPageViewStep extends StatelessWidget {
  const CustomAddExamQuestionsPageViewStep(
      {super.key,
      required this.coursetestentity,
      required this.questionsFormKey});
  final CourseTestEntity coursetestentity;
  final GlobalKey<FormState> questionsFormKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: Form(
        key: questionsFormKey,
        child: CustomScrollView(
          slivers: [
            const SliverToBoxAdapter(
                child: AddCourseSectionExamListviewHeader()),
            AddCourseSectionExamListview(
              coursetestentity: coursetestentity,
            ),
            SliverToBoxAdapter(
              child: AddQuestionButton(coursetestentity: coursetestentity),
            )
          ],
        ),
      ),
    );
  }
}
