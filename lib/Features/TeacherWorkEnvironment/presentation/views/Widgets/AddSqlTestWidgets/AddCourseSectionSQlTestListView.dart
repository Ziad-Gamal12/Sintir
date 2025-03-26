import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddSqlTestWidgets/AddCourseSQLAddQuestionListItem.dart';

class Addcoursesectionsqltestlistview extends StatelessWidget {
  const Addcoursesectionsqltestlistview(
      {super.key, required this.coursetestentity});
  final Coursetestentity coursetestentity;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Addcoursesqladdquestionlistitem(
              coursetestquestionentity: coursetestentity.questions[index],
              coursetestentity: coursetestentity,
            ),
          );
        },
        itemCount: coursetestentity.questions.length);
  }
}
