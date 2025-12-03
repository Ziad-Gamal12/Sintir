import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomUserInfoItem extends StatelessWidget {
  const CustomUserInfoItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor, // Added optional color property
  });

  final String title, value;
  final IconData icon;
  final Color? iconColor; // Added optional iconColor property

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final Color effectiveIconColor = iconColor ?? theme.colorScheme.primary;

    // Use a light, contrasting background for the icon circle, derived from the background color
    final Color circleBackgroundColor =
        theme.scaffoldBackgroundColor.withOpacity(0.8);

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
          radius: 22,
          backgroundColor: circleBackgroundColor,
          child: Icon(icon, color: effectiveIconColor, size: 20)),
      title: Text(
        title,
        style: AppTextStyles(context)
            .semiBold14
            .copyWith(color: secondaryTextColor),
      ),
      subtitle: Text(
        value,
        style: AppTextStyles(context).regular14.copyWith(
            color:
                primaryTextColor), // Use primary text color for the main value
      ),
    );
  }
}
