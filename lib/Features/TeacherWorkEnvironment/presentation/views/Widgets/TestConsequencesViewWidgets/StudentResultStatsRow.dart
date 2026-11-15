import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetailsHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatusChip.dart';
import 'package:sintir/locale_keys.dart';

class StudentResultStatsRow extends StatelessWidget {
  const StudentResultStatsRow({
    super.key,
    required this.testResultEntity,
    required this.statusColor,
  });

  final TestResultEntity testResultEntity;
  final Color statusColor;

  static String _formatPercent(double value) {
    final text = value.toStringAsFixed(1);
    return text.endsWith('.0') ? text.substring(0, text.length - 2) : text;
  }

  @override
  Widget build(BuildContext context) {
    final style = AppTextStyles(context);
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    final rawPercent = ResultDetailsHelper.getResultPercent(
      testResultEntity,
    ).toDouble();
    final percent = rawPercent.isFinite
        ? rawPercent.clamp(0.0, 100.0).toDouble()
        : 0.0;

    final correct = ResultDetailsHelper.getSuccessQuestions(
      testResultEntity,
    ).length;
    final total = testResultEntity.totalQuestions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                '${_formatPercent(percent)}%',
                style: style.semiBold20.copyWith(color: statusColor),
              ),
            ),
            const SizedBox(width: 8),
            StudentResultStatusChip(
              isPassed: testResultEntity.isPassed,
              color: statusColor,
            ),
            Expanded(
              child: Align(
                alignment: AlignmentDirectional.centerEnd,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Directionality(
                      textDirection: TextDirection.ltr,
                      child: Text('$correct/$total', style: style.semiBold14),
                    ),
                    Text(
                      LocaleKeys.correctAnswers,
                      style: style.regular11.copyWith(color: muted),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        _ResultProgressBar(value: percent / 100, color: statusColor),
      ],
    );
  }
}

class _ResultProgressBar extends StatelessWidget {
  const _ResultProgressBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(99),
      child: SizedBox(
        height: 8,
        child: ColoredBox(
          color: color.withValues(alpha: .16),
          child: Align(
            alignment: AlignmentDirectional.centerStart,
            child: FractionallySizedBox(
              widthFactor: value.clamp(0.0, 1.0).toDouble(),
              heightFactor: 1,
              child: ColoredBox(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
