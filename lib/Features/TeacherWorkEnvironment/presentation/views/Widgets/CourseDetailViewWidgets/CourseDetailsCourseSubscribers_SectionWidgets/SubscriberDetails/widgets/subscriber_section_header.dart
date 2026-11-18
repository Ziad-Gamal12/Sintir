import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class SubscriberSectionHeader extends StatelessWidget {
  const SubscriberSectionHeader({
    super.key,
    required this.title,
    this.trailing,
  });
  final String title;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      Text(
        title,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles(
          context,
        ).semiBold16.copyWith(color: Theme.of(context).colorScheme.onSurface),
      ),
      if (trailing != null) ...[const SizedBox(width: 8), trailing!],
    ],
  );
}
