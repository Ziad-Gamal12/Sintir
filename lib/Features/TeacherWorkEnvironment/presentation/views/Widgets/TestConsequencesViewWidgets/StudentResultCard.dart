import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentInfoTexts.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCardDisplayFullResultWIdget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatsRow.dart';

class StudentResultCard extends StatelessWidget {
  const StudentResultCard({super.key, required this.testResultEntity});
  final TestResultEntity testResultEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.light
                ? Colors.grey.shade100
                : Colors.black26,
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? Colors.grey.shade50
              : Colors.white10,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentResultCardAction(testResultEntity: testResultEntity),
          const SizedBox(height: 10),

          /// Top Row — Avatar + Info + Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StudentAvatar(url: testResultEntity.joinedbyentity.imageUrl),
              const SizedBox(width: 16),
              Expanded(child: StudentInfoTexts(testResult: testResultEntity)),
              const SizedBox(width: 8),
            ],
          ),

          const SizedBox(height: 18),
          Divider(
            thickness: 0.6,
            color: theme.dividerColor,
          ),

          /// Stats
          const Spacer(),
          StudentResultStatsRow(testResultEntity: testResultEntity),
          const Spacer(),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .moveY(begin: 20, curve: Curves.easeOut);
  }
}
