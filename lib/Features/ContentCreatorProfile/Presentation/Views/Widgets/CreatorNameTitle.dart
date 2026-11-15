import 'package:flutter/material.dart';
import 'package:lucide_icons_flutter/lucide_icons.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CreatorNameTitle extends StatelessWidget {
  final String name;
  final String title;

  const CreatorNameTitle({super.key, required this.name, required this.title});

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.titleLarge!.color!;
    final Color secondaryTextColor = theme.textTheme.bodyMedium!.color!;
    final Color verificationColor = theme.colorScheme.secondary;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles(
            context,
          ).semiBold20.copyWith(color: primaryTextColor),
        ),
        const SizedBox(height: 6),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(LucideIcons.badgeCheck, size: 18, color: verificationColor),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTextStyles(
                  context,
                ).regular14.copyWith(color: secondaryTextColor),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
