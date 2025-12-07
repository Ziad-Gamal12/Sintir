import 'package:flutter/material.dart';
import 'package:sintir/Core/widgets/CustomCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TestConsequencesViewRequirements.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/CustomTestInfo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/TestStatsInfo.dart';

class TestSummaryCard extends StatelessWidget {
  const TestSummaryCard({super.key, required this.requirements});
  final TestConsequencesViewRequirements requirements;

  @override
  Widget build(BuildContext context) {
    return CustomCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTestInfo(
            test: requirements.test,
            courseId: requirements.courseID,
            sectionId: requirements.sectionID,
          ),
          const SizedBox(height: 20),
          TestStatsInfo(
            requirements: requirements,
          )
        ],
      ),
    );
  }
}
