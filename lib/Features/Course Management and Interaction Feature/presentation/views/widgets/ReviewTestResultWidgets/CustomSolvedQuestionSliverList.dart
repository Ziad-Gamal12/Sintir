import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/TestResulteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItem.dart';

class Customsolvedquestionsliverlist extends StatelessWidget {
  const Customsolvedquestionsliverlist({super.key});

  @override
  Widget build(BuildContext context) {
    List<ExamResultSolvedQuestionEntity> questions =
        context.read<TestresulteEntity>().questionsSolvedListEntity;
    return SliverList.builder(
        itemCount: questions.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: CustomSolvedQuestionListItem(
              examResultSolvedQuestionEntity: questions[index],
            ),
          );
        });
  }
}
