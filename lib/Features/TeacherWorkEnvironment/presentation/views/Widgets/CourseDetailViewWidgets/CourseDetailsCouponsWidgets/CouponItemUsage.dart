import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

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
    final locale = Localizations.localeOf(context).languageCode;

    return Row(
      children: [
        Text(
          LocaleKeys.couponUsageCount(
            LocaleFormatter.number(usedCount, locale),
            LocaleFormatter.number(usageLimit, locale),
          ),
          style: AppTextStyles(
            context,
          ).semiBold11.copyWith(color: _color(theme: theme)),
        ),
        SizedBox(width: 4),
        Text(
          hasReachedLimit
              ? "(${LocaleKeys.couponLimitReached})"
              : LocaleKeys.couponUsageSuffix,
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
