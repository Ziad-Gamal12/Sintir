import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CreatorStats extends StatelessWidget {
  final int coursesCount;
  final int subscribersCount;

  const CreatorStats({
    super.key,
    required this.coursesCount,
    required this.subscribersCount,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);

    return IntrinsicHeight(
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              context: context,
              icon: LucideIcons.bookOpen,
              label: LocaleKeys.coursesLabel,
              value: coursesCount.toString(),
            ),
          ),
          VerticalDivider(
            color: theme.dividerColor.withValues(alpha: 0.08),
            thickness: 1,
            width: 24,
          ),
          Expanded(
            child: _buildStatItem(
              context: context,
              icon: LucideIcons.users,
              label: LocaleKeys.studentsLabel,
              value: subscribersCount.toString(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor = theme.colorScheme.primary;
    final Color primaryTextColor = theme.textTheme.titleLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, size: 20, color: primaryColor),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Text(
                value,
                key: ValueKey<String>(value),
                style: AppTextStyles(
                  context,
                ).semiBold16.copyWith(color: primaryTextColor, height: 1.1),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles(
                context,
              ).regular13.copyWith(color: secondaryTextColor),
            ),
          ],
        ),
      ],
    );
  }
}
