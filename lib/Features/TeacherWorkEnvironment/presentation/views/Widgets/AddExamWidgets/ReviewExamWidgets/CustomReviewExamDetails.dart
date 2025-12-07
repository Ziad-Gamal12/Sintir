import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/navigateExamReviewRequirmentsEntity.dart';
import 'package:sintir/locale_keys.dart';

class TestSummaryCard extends StatelessWidget {
  const TestSummaryCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final bool isDarkMode = theme.brightness == Brightness.dark;

    final List<BoxShadow> mainShadow = isDarkMode
        ? [
            BoxShadow(
              color: Colors.white.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 5),
            )
          ]
        : const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 10),
            )
          ];

    // Read entity from context
    CourseTestEntity courseTestEntity =
        context.read<NavigateExamReviewRequirmentsEntity>().coursetestentity;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      decoration: BoxDecoration(
        // Use theme-aware color
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
        // Use theme-aware shadow
        boxShadow: mainShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            courseTestEntity.title,
            style: AppTextStyles(context)
                .semiBold20
                // Use primaryTextColor
                .copyWith(color: primaryTextColor),
          ),
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInfoItem(
                context: context,
                icon: Icons.timer_rounded,
                label: LocaleKeys.examDuration,
                value:
                    "${courseTestEntity.durationTime} ${LocaleKeys.durationMinutes}",
              ),
              const SizedBox(width: 25),
              _buildInfoItem(
                context: context,
                icon: Icons.help_outline_rounded,
                label: LocaleKeys.numberOfQuestions,
                value:
                    "${courseTestEntity.questions.length} ${LocaleKeys.questionsCount}",
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Helper widget updated for dark mode
  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    final ThemeData theme = Theme.of(context);
    final Color iconBoxColor = theme.cardColor;
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color iconColor = theme.primaryColor;
    final bool isDarkMode = theme.brightness == Brightness.dark;

    final List<BoxShadow> nestedShadow = isDarkMode
        ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              blurRadius: 8,
              offset: const Offset(0, 5),
            )
          ]
        : const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 10),
            )
          ];

    return Expanded(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
            ),
            decoration: BoxDecoration(
              color: iconBoxColor,
              borderRadius: BorderRadius.circular(14),
              boxShadow: nestedShadow,
            ),
            child: Icon(
              icon,
              // Use theme-aware color for the icon
              color: iconColor,
              size: 22,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  child: Text(
                    label,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles(context)
                        .regular14
                        // Use theme-aware text color for the label
                        .copyWith(color: primaryTextColor.withOpacity(0.7)),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyles(context)
                      .semiBold16
                      // Use theme-aware text color for the value
                      .copyWith(color: primaryTextColor),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
