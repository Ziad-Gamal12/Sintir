import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/locale_keys.dart';

class TestSummaryCard extends StatelessWidget {
  const TestSummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;

    final CourseTestEntity entity =
        context.read<NavigateExamReviewRequirmentsEntity>().coursetestentity;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
            color: theme.dividerColor.withOpacity(isDark ? 0.1 : 0.05)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(isDark ? 0.4 : 0.08),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Section
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.assignment_turned_in_rounded,
                    color: colorScheme.primary),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  entity.title,
                  style: AppTextStyles(context).semiBold20.copyWith(
                        color: theme.textTheme.bodyLarge?.color,
                        letterSpacing: -0.5,
                      ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            childAspectRatio: 2.2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            children: [
              _buildModernItem(
                context,
                icon: Icons.timer_rounded,
                label: LocaleKeys.examDuration,
                value: "${entity.durationTime} ${LocaleKeys.durationMinutes}",
              ),
              _buildModernItem(
                context,
                icon: Icons.help_center_rounded,
                label: LocaleKeys.numberOfQuestions,
                value: "${entity.questions.length}",
              ),
              _buildModernItem(
                context,
                icon: Icons.refresh_rounded,
                label: LocaleKeys.examAttemptsCount,
                value:
                    entity.numberOfAttempts?.toString() ?? LocaleKeys.unlimited,
              ),
              _buildModernItem(
                context,
                icon: Icons.visibility_off_rounded,
                label: LocaleKeys.hideResultAfterSubmit,
                value: entity.showResult ? LocaleKeys.no : LocaleKeys.yes,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildModernItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
  }) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    return Row(
      children: [
        Icon(icon, size: 20, color: primaryColor.withOpacity(0.6)),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                label,
                style: AppTextStyles(context).regular13.copyWith(
                      color: theme.textTheme.bodySmall?.color,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                value,
                style: AppTextStyles(context).semiBold14.copyWith(
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
