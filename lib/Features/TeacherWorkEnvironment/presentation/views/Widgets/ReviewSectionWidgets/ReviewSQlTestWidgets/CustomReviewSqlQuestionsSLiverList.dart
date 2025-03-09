import 'package:flutter/material.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewSectionWidgets/ReviewSQlTestWidgets/CustomReviewSqlQuestionListItem.dart';

class Customreviewsqlquestionssliverlist extends StatelessWidget {
  const Customreviewsqlquestionssliverlist(
      {super.key, required this.questions});
  final List<Coursetestquestionentity> questions;
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: CustomReviewSqlQuestionListItem(
              question: questions[index],
            ),
          );
        });
  }
}
