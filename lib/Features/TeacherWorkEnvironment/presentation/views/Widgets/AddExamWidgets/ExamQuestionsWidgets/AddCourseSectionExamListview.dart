import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/ExamQuestionsWidgets/AddCourseExamAddQuestionListViewItem.dart';

class AddCourseSectionExamListview extends StatelessWidget {
  const AddCourseSectionExamListview({
    super.key,
    required this.coursetestentity,
  });
  final CourseTestEntity coursetestentity;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      buildWhen: (previous, current) {
        return current is AddCourseSectionTestQuestionAdded ||
            current is AddCourseSectionTestQuestionRemoved;
      },
      builder: (context, state) {
        // Every card is built up front rather than lazily (SliverList.builder)
        // so all of them stay mounted: the questions form then validates and
        // saves the off-screen ones too, and the Save button can scroll to any
        // question that still lacks a correct answer. Exams have tens of
        // questions, so this stays cheap.
        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              for (final (index, question)
                  in coursetestentity.questions.indexed)
                Padding(
                  key: ObjectKey(question),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: AddCourseExamAddQuestionListViewItem(
                    index: index,
                    coursetestquestionentity: question,
                    coursetestentity: coursetestentity,
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
