import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/presentation/views/ReviewTestResultView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentAvatar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentInfoTexts.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultCardDisplayFullResultWIdget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TestConsequencesViewWidgets/StudentResultStatsRow.dart';

class StudentResultCard extends StatelessWidget {
  const StudentResultCard({super.key, required this.testResultEntity});
  final TestResultEntity testResultEntity;

  Color _statusColor(ThemeData theme) {
    if (!testResultEntity.isPassed) return theme.colorScheme.error;
    return theme.brightness == Brightness.dark
        ? Colors.green.shade400
        : Colors.green.shade800;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final radius = BorderRadius.circular(18);
    final statusColor = _statusColor(theme);

    return DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: radius,
            boxShadow: [
              BoxShadow(
                color: theme.shadowColor.withValues(alpha: isDark ? .16 : .06),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Material(
            color: theme.cardColor,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: radius,
              side: BorderSide(
                color: theme.dividerColor.withValues(alpha: isDark ? .6 : .45),
              ),
            ),
            child: InkWell(
              onTap: () {
                GoRouter.of(
                  context,
                ).push(Reviewtestresultview.routeName, extra: testResultEntity);
              },
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        StudentAvatar(
                          url: testResultEntity.joinedbyentity.imageUrl,
                          name: testResultEntity.joinedbyentity.name,
                          ringColor: statusColor,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: StudentInfoTexts(
                            testResult: testResultEntity,
                            statusColor: statusColor,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    StudentResultStatsRow(
                      testResultEntity: testResultEntity,
                      statusColor: statusColor,
                    ),
                    const SizedBox(height: 12),
                    Divider(
                      height: 1,
                      thickness: 1,
                      color: theme.dividerColor.withValues(alpha: .5),
                    ),
                    const SizedBox(height: 8),

                    /// What next: the whole card is tappable, this is the hint.
                    const StudentResultCardAction(),
                  ],
                ),
              ),
            ),
          ),
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .moveY(begin: 20, curve: Curves.easeOut);
  }
}
