import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/responsive/breakpoints.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseSectionExamListview.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseSectionExamListviewHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddQuestionButton.dart';
import 'package:sintir/constant.dart';

class CustomAddExamQuestionsPageViewStep extends StatelessWidget {
  const CustomAddExamQuestionsPageViewStep({
    super.key,
    required this.coursetestentity,
    required this.questionsFormKey,
  });
  final CourseTestEntity coursetestentity;
  final GlobalKey<FormState> questionsFormKey;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: KVerticalPadding),
      child: Form(
        key: questionsFormKey,
        child: LayoutBuilder(
          builder: (context, constraints) => CustomScrollView(
            slivers: [
              SliverPadding(
                padding: EdgeInsets.symmetric(
                  horizontal: ContentWidth.gutter(
                    constraints.maxWidth,
                    ContentWidth.reading,
                    min: KHorizontalPadding,
                  ),
                ),
                sliver: SliverMainAxisGroup(
                  slivers: [
                    const SliverToBoxAdapter(
                      child: AddCourseSectionExamListviewHeader(),
                    ),
                    AddCourseSectionExamListview(
                      coursetestentity: coursetestentity,
                    ),
                    SliverToBoxAdapter(
                      child: AddQuestionButton(
                        coursetestentity: coursetestentity,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
