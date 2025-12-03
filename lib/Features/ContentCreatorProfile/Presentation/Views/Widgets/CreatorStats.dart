import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildStatItem(
          context: context,
          icon: LucideIcons.bookOpen,
          label: LocaleKeys.coursesLabel,
          value: coursesCount.toString(),
        ),
        _buildStatItem(
          context: context,
          icon: LucideIcons.users,
          label: LocaleKeys.studentsLabel,
          value: subscribersCount.toString(),
        ),
      ],
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String label,
    required String value,
    required BuildContext context,
  }) {
    final ThemeData theme = Theme.of(context);
    final Color primaryColor =
        theme.colorScheme.primary; // Use primary color for icons and values
    final Color secondaryTextColor =
        theme.textTheme.bodyMedium!.color!; // Use muted color for the label

    return Column(
      children: [
        Icon(icon,
            size: 22,
            color: primaryColor), // Use theme primary color for the icon
        const SizedBox(height: 4),
        AnimatedSwitcher(
            duration: const Duration(milliseconds: 500),
            switchInCurve: Curves.easeOutBack,
            switchOutCurve: Curves.easeIn,
            key: ValueKey(value),
            child: Text(
              value,
              style: AppTextStyles(context).semiBold16.copyWith(
                    color:
                        primaryColor, // Use theme primary color for the value
                  ),
            )),
        Text(
          label,
          style: AppTextStyles(context).regular14.copyWith(
              color:
                  secondaryTextColor), // Use theme secondary text color for the label
        ),
      ],
    );
  }
}
