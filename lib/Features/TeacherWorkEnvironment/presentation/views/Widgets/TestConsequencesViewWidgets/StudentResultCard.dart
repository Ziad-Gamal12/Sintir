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
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: theme.brightness == Brightness.light
                ? theme.shadowColor.withValues(alpha: .06)
                : theme.shadowColor.withValues(alpha: .16),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? theme.dividerColor.withValues(alpha: .45)
              : theme.dividerColor.withValues(alpha: .6),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          StudentResultCardAction(testResultEntity: testResultEntity),
          const SizedBox(height: 8),

          /// Top Row — Avatar + Info + Button
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              StudentAvatar(url: testResultEntity.joinedbyentity.imageUrl),
              const SizedBox(width: 12),
              Expanded(child: StudentInfoTexts(testResult: testResultEntity)),
              const SizedBox(width: 8),
            ],
          ),

          const SizedBox(height: 12),
          Divider(
              height: 1,
              thickness: 1,
              color: theme.dividerColor.withValues(alpha: .5)),
          const SizedBox(height: 12),
          StudentResultStatsRow(testResultEntity: testResultEntity),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 400.ms)
        .moveY(begin: 20, curve: Curves.easeOut);
  }
}
