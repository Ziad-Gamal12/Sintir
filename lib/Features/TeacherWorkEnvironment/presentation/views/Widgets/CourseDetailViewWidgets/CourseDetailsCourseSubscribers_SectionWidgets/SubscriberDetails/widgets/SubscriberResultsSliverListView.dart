import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCard.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberResultsSliverListView extends StatelessWidget {
  const SubscriberResultsSliverListView({super.key, required this.testResults});
  final List<TestResultEntity> testResults;
  @override
  Widget build(BuildContext context) {
    if (testResults.isEmpty) {
      return SliverToBoxAdapter(
        child: CustomEmptyWidget(
          text: LocaleKeys.noResults,
        ),
      );
    }
    return SliverList.builder(
      itemCount: testResults.length,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: AspectRatio(
            aspectRatio: 2 / 1.75,
            child: StudentResultCard(
              testResultEntity: testResults[index],
            ),
          ),
        );
      },
    );
  }
}
