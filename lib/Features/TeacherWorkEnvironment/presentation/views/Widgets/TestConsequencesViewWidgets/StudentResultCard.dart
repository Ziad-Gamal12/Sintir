import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/ResultSemanticColors.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentInfoTexts.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatsRow.dart';
import 'package:sintir/locale_keys.dart';

class StudentResultCard extends StatelessWidget {
  const StudentResultCard({super.key, required this.testResultEntity});
  final TestResultEntity testResultEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isRtl = Directionality.of(context) == TextDirection.rtl;
    final radius = BorderRadius.circular(16);
    final hasValidQuestions = testResultEntity.totalQuestions > 0;

    final semanticTokens = ResultSemanticColors.resolve(
      isDark: isDark,
      hasValidQuestions: hasValidQuestions,
      isPassed: testResultEntity.isPassed,
    );

    final studentName = testResultEntity.joinedbyentity.name.trim();
    final statusLabel = hasValidQuestions
        ? (testResultEntity.isPassed ? LocaleKeys.passed : LocaleKeys.failed)
        : LocaleKeys.notAvailable;

    final scheme = theme.colorScheme;

    final cardSurfaceColor = scheme.surface;

    final cardBorderColor = scheme.onSurface.withValues(
      alpha: isDark ? 0.08 : 0.10,
    );

    return Semantics(
      button: true,
      label: '$studentName, $statusLabel',
      child: Container(
        decoration: BoxDecoration(
          borderRadius: radius,
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: const Color(0x0A000000),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Material(
          color: cardSurfaceColor,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: radius,
            side: BorderSide(color: cardBorderColor, width: 0.8),
          ),
          child: InkWell(
            onTap: () {
              GoRouter.of(
                context,
              ).push(Reviewtestresultview.routeName, extra: testResultEntity);
            },
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      StudentAvatar(
                        url: testResultEntity.joinedbyentity.imageUrl,
                        name: studentName,
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: StudentInfoTexts(
                          testResult: testResultEntity,
                          statusColor: semanticTokens.foreground,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        isRtl
                            ? Icons.chevron_left_rounded
                            : Icons.chevron_right_rounded,
                        size: 20,
                        color: theme.colorScheme.onSurfaceVariant.withValues(
                          alpha: isDark ? 0.35 : 0.45,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  StudentResultStatsRow(
                    testResultEntity: testResultEntity,
                    statusColor: semanticTokens.foreground,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
