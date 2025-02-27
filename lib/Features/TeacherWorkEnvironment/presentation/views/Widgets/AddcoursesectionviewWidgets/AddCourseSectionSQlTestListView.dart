import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddcoursesectionviewWidgets/AddCourseSQLAddQuestionListItem.dart';

class Addcoursesectionsqltestlistview extends StatelessWidget {
  const Addcoursesectionsqltestlistview({super.key, required this.questions});
  final List<Coursetestquestionentity> questions;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Addcoursesqladdquestionlistitem(
              coursetestquestionentity: questions[index],
            ),
          );
        },
        itemCount: questions.length);
  }
}
