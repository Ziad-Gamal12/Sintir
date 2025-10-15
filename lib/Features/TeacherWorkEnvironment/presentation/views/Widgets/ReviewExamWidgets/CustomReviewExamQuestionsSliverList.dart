import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateSQlReviewRequirmentsEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/ReviewExamWidgets/CustomReviewExamQuestionListItem.dart';

class CustomReviewExamQuestionsSliverList extends StatelessWidget {
  const CustomReviewExamQuestionsSliverList({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    List<CourseTestQuestionEntity> questions = context
        .read<NavigateExamReviewRequirmentsEntity>()
        .coursetestentity
        .questions;
    return SliverList.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: CustomReviewExamQuestionListItem(
              index: index,
              totalQuestions: questions.length,
              question: questions[index],
            ),
          );
        });
  }
}
