import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/ExamResultSolvedQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/CustomSolvedQuestionListItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GetMyMistakesViewBodyListViewLoading extends StatelessWidget {
  const GetMyMistakesViewBodyListViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: ExamResultSolvedQuestionEntity.empty().length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Skeletonizer(
            enabled: true,
            child: CustomSolvedQuestionListItem(
              index: index,
              length: ExamResultSolvedQuestionEntity.empty().length,
              examResultSolvedQuestionEntity:
                  ExamResultSolvedQuestionEntity.empty()[index],
            )),
      ),
    );
  }
}
