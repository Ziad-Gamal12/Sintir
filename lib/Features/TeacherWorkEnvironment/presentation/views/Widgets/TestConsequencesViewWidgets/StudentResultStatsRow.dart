import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/utils/imageAssets.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/widgets/ReviewTestResultWidgets/ResultDetailsHelper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultSemanticColors.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatusChip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentStatItem.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class StudentResultStatsRow extends StatelessWidget {
  const StudentResultStatsRow({
    super.key,
    required this.testResultEntity,
    this.statusColor,
  });

  final TestResultEntity testResultEntity;
  final Color? statusColor;

  static String _formatPercent(double value) {
    final text = value.toStringAsFixed(1);
    return text.endsWith('.0') ? text.substring(0, text.length - 2) : text;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final total = testResultEntity.totalQuestions;
    final isDefined = total > 0;

    final String percentText;
    final String scoreText;

    if (!isDefined) {
      // Denominator invalid / zero-question test: show explicit undefined placeholder
      percentText = '—';
      scoreText = '—';
    } else {
      final rawPercent = ResultDetailsHelper.getResultPercent(
        testResultEntity,
      ).toDouble();
      final percent = rawPercent.isFinite
          ? rawPercent.clamp(0.0, 100.0).toDouble()
          : 0.0;
      percentText = '${_formatPercent(percent)}%';

      final correct = ResultDetailsHelper.getSuccessQuestions(
        testResultEntity,
      ).length;
      scoreText = '$correct/$total';
    }

    final semanticTokens = ResultSemanticColors.resolve(
      isDark: isDark,
      hasValidQuestions: isDefined,
      isPassed: testResultEntity.isPassed,
    );

    final statusChipWidget = isDefined
        ? StudentResultStatusChip(
            isPassed: testResultEntity.isPassed,
            color: statusColor,
            semanticColors: semanticTokens,
            isCompact: true,
          )
        : StudentResultStatusChip(
            isPassed: false,
            color: statusColor,
            semanticColors: semanticTokens,
            label: LocaleKeys.notAvailable,
            icon: Icons.remove_circle_outline_rounded,
            isCompact: true,
          );

    return Row(
      children: [
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsGraphBar,
            title: LocaleKeys.evaluationRate,
            value: percentText,
            backgroundColor: KMainColor,
            isHero: true,
            statusChip: statusChipWidget,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: StudentStatItem(
            icon: Assets.assetsIconsMisionIcon,
            title: LocaleKeys.studentScore,
            value: scoreText,
            backgroundColor: KSecondaryColor,
          ),
        ),
      ],
    );
  }
}
