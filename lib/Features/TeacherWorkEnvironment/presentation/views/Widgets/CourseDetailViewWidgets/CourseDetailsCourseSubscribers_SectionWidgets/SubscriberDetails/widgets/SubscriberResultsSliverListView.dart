import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';

class SubscriberResultsSliverListView extends StatelessWidget {
  const SubscriberResultsSliverListView({super.key, required this.testResults});
  final List<TestResultEntity> testResults;
  @override
  Widget build(BuildContext context) {
    if (testResults.isEmpty) {
      return SliverToBoxAdapter(
        child: CustomEmptyWidget(
          text: "لا يوجد نتايج",
        ),
      );
    }
    return SliverList.builder(
      itemCount: testResults.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AspectRatio(
            aspectRatio: 2 / 1.1,
            child: StudentResultCard(
              testResultEntity: testResults[index],
            ),
          ),
        );
      },
    );
  }
}
