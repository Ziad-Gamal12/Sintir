import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CreatorNameTitle extends StatelessWidget {
  final String name;
  final String title;

  const CreatorNameTitle({
    super.key,
    required this.name,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    // Determine primary and secondary text/icon colors from the theme
    final Color primaryTextColor = theme.textTheme.titleLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final Color primaryIconColor =
        theme.colorScheme.primary; // Use primary for strong icons
    final Color verificationColor = theme.colorScheme
        .secondary; // Use secondary or a specific success/accent color for verification icon

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.user2,
                size: 22,
                color:
                    primaryTextColor), // Use primary text color for the user icon
            const SizedBox(width: 6),
            Text(
              name,
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: primaryTextColor), // Use primary text color
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(LucideIcons.badgeCheck,
                size: 20,
                color:
                    verificationColor), // Use theme color for badge/verification
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles(context).regular16.copyWith(
                  color:
                      secondaryTextColor), // Use secondary text color for the title
            ),
          ],
        ),
      ],
    );
  }
}
