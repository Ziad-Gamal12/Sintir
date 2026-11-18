import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CouponItemUsage extends StatelessWidget {
  const CouponItemUsage({
    super.key,
    required this.usedCount,
    required this.usageLimit,
    required this.hasReachedLimit,
  });
  final int usedCount, usageLimit;
  final bool hasReachedLimit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Text(
          "$usedCount من $usageLimit",
          style: AppTextStyles(
            context,
          ).semiBold11.copyWith(color: _color(theme: theme)),
        ),
        SizedBox(width: 4),
        Text(
          hasReachedLimit ? "(اكتمل الحد)" : "استخدام",
          style: AppTextStyles(
            context,
          ).regular11.copyWith(color: _color(theme: theme)),
        ),
      ],
    );
  }

  Color _color({required ThemeData theme}) {
    if (hasReachedLimit) {
      return theme.colorScheme.secondary;
    }
    bool isDark = theme.brightness == Brightness.dark;
    if (isDark) {
      return Colors.white;
    } else {
      return Colors.black;
    }
  }
}
