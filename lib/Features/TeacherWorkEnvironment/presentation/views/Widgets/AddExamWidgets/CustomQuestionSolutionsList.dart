// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/AddExamWidgets/CustomQuestionSolutionsListCustomSolutionItem.dart';

class CustomQuestionSolutionsList extends StatelessWidget {
  const CustomQuestionSolutionsList({
    super.key,
    required this.coursetestentity,
    required this.question,
  });
  final CourseTestEntity coursetestentity;
  final CourseTestQuestionEntity question;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: question.solutions.asMap().entries.map((e) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: CustomQuestionSolutionsListCustomSolutionItem(
            e: e,
            question: question,
            coursetestentity: coursetestentity,
          ),
        );
      }).toList(),
    );
  }
}
