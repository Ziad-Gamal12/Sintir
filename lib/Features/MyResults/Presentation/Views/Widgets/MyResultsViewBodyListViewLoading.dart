import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:skeletonizer/skeletonizer.dart';

class MyResultsViewBodyListViewLoading extends StatelessWidget {
  const MyResultsViewBodyListViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: getFakeLoadingSubscribers().length,
      itemBuilder: (context, index) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Skeletonizer(
          enabled: true,
          child: AspectRatio(
            aspectRatio: 2 / 1.1,
            child: StudentResultCard(
              testResultEntity: getFakeLoadingSubscribers()[index],
            ),
          ),
        ),
      ),
    );
  }

  List<TestResultEntity> getFakeLoadingSubscribers() {
    return List.generate(6, (index) => TestResultEntity.empty());
  }
}
