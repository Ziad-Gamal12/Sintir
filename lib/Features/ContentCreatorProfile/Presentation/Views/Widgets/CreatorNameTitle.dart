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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.user2, size: 22, color: Colors.black87),
            const SizedBox(width: 6),
            Text(
              name,
              style: AppTextStyles(context)
                  .semiBold20
                  .copyWith(color: Colors.black87),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(LucideIcons.badgeCheck,
                size: 20, color: Colors.blueAccent),
            const SizedBox(width: 6),
            Text(
              title,
              style: AppTextStyles(context)
                  .regular16
                  .copyWith(color: Colors.black54),
            ),
          ],
        ),
      ],
    );
  }
}
