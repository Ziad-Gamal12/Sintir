import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetailsPercentCircle.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetailsStatsGrid.dart';

class ResultDetails extends StatelessWidget {
  const ResultDetails({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    TestResultEntity testresulteEntity = context.read<TestResultEntity>();
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          ResultDetailsPercentCircle(testresulteEntity: testresulteEntity),
          const SizedBox(height: 20),
          ResultDetailsStatsGrid(testresulteEntity: testresulteEntity),
        ],
      ),
    );
  }
}
