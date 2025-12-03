import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestViewNavigationsRequirmentsEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/CourseTestOverViewBodyJoinExamButton.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/ExamDuration.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/presentation/views/widgets/CourseTestOverViewBodyWidgets/ExamQuestionsCount.dart';

class OverviewHeaderCard extends StatelessWidget {
  const OverviewHeaderCard({super.key, required this.entity});
  final CourseExamViewNavigationsRequirmentsEntity entity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark ? theme.cardColor : Colors.white,
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : Colors.black26,
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            entity.test.title,
            overflow: TextOverflow.ellipsis,
            style: AppTextStyles(context)
                .semiBold20
                .copyWith(color: isDark ? Colors.white : Colors.black),
          ),
          const SizedBox(height: 12),
          _OverviewHeaderRow(entity: entity),
          const SizedBox(height: 24),
          CourseTestOverViewBodyJoinExamButton(
              courseExamViewNavigationsRequirmentsEntity: entity),
        ],
      ),
    );
  }
}

class _OverviewHeaderRow extends StatelessWidget {
  const _OverviewHeaderRow({required this.entity});
  final CourseExamViewNavigationsRequirmentsEntity entity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ExamDuration(
          duration: entity.test.durationTime,
        ),
        ExamQuestionsCount(questionsCount: entity.test.questions.length),
      ],
    );
  }
}
