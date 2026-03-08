import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/QuestionMistakeEntity.dart';
import 'package:sintir/Features/MyMistakes/Presentation/Views/Widgets/MyMistakeCardItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class GetMyMistakesViewBodyListViewLoading extends StatelessWidget {
  const GetMyMistakesViewBodyListViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: QuestionMistakeEntity.empty().length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Skeletonizer(
            enabled: true,
            child: MyMistakeCardItem(
              mistake: QuestionMistakeEntity.empty()[index],
            )),
      ),
    );
  }
}
