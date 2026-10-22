import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemExpiry extends StatelessWidget {
  const CourseCouponGridViewItemExpiry(
      {super.key, required this.expirationDate, required this.hasReachedLimit});
  final DateTime expirationDate;
  final bool hasReachedLimit;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;

    return Row(
      children: [
        Icon(
          hasReachedLimit ? Icons.history : Icons.calendar_month_rounded,
          color: hasReachedLimit
              ? Color(0xff8E909F).withAlpha(80)
              : Color(0xff8E909F),
          size: 16,
        ),
        SizedBox(
          width: 6,
        ),
        Text(
          "${LocaleKeys.expiresIn}: ${expirationDate.day} / ${expirationDate.month} / ${expirationDate.year}",
          style: AppTextStyles(context).regular14.copyWith(
              color: hasReachedLimit
                  ? primaryTextColor.withAlpha(60)
                  : primaryTextColor),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}
