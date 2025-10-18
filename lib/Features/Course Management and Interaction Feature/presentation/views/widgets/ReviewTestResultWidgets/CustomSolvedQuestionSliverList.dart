import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItem.dart';

class Customsolvedquestionsliverlist extends StatelessWidget {
  const Customsolvedquestionsliverlist({super.key});

  @override
  Widget build(BuildContext context) {
    List<ExamResultSolvedQuestionEntity> examResult =
        context.read<TestResultEntity>().questionsSolvedListEntity;
    return SliverList.builder(
        itemCount: examResult.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomSolvedQuestionListItem(
              index: index,
              length: examResult.length,
              examResultSolvedQuestionEntity: examResult[index],
            ),
          );
        });
  }
}
