import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CustomUserInfoItem extends StatelessWidget {
  const CustomUserInfoItem({
    super.key,
    required this.title,
    required this.value,
    required this.icon,
    this.iconColor,
  });

  final String title, value;
  final FaIconData icon;
  final Color? iconColor;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final Color effectiveIconColor = iconColor ?? theme.colorScheme.primary;

    final Color circleBackgroundColor =
        theme.scaffoldBackgroundColor.withValues(alpha: 0.8);

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircleAvatar(
          radius: 22,
          backgroundColor: circleBackgroundColor,
          child: FaIcon(icon, color: effectiveIconColor, size: 20)),
      title: Text(
        title,
        style: AppTextStyles(context)
            .semiBold14
            .copyWith(color: secondaryTextColor),
      ),
      subtitle: Text(
        value,
        style:
            AppTextStyles(context).regular14.copyWith(color: primaryTextColor),
      ),
    );
  }
}
