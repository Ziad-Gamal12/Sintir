import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/AddCourseExamAddQuestionListViewItem.dart';

class AddCourseSectionExamListview extends StatelessWidget {
  const AddCourseSectionExamListview(
      {super.key, required this.coursetestentity});
  final CourseTestEntity coursetestentity;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: AddCourseExamAddQuestionListViewItem(
              coursetestquestionentity: coursetestentity.questions[index],
              coursetestentity: coursetestentity,
            ),
          );
        },
        itemCount: coursetestentity.questions.length);
  }
}
