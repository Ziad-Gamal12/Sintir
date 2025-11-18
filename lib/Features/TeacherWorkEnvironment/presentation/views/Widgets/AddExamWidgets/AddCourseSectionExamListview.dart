import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/test_item_cubit/test_item_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseExamAddQuestionListViewItem.dart';

class AddCourseSectionExamListview extends StatelessWidget {
  const AddCourseSectionExamListview(
      {super.key, required this.coursetestentity});
  final CourseTestEntity coursetestentity;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TestItemCubit, TestItemState>(
      buildWhen: (previous, current) {
        if (current is AddCourseSectionTestQuestionAdded ||
            current is AddCourseSectionTestQuestionRemoved) {
          return true;
        }
        return false;
      },
      builder: (context, state) {
        return SliverList.builder(
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: AddCourseExamAddQuestionListViewItem(
                  index: index,
                  coursetestquestionentity: coursetestentity.questions[index],
                  coursetestentity: coursetestentity,
                ),
              );
            },
            itemCount: coursetestentity.questions.length);
      },
    );
  }
}
