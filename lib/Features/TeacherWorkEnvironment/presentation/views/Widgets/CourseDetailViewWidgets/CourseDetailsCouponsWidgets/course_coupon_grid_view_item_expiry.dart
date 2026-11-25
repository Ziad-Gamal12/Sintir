import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemExpiry extends StatelessWidget {
  const CourseCouponGridViewItemExpiry({
    super.key,
    required this.expirationDate,
    required this.hasReachedLimit,
  });
  final DateTime expirationDate;
  final bool hasReachedLimit;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color primaryTextColor = theme.textTheme.bodyLarge!.color!;
    final locale = Localizations.localeOf(context).languageCode;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          hasReachedLimit ? Icons.history : Icons.calendar_month_rounded,
          color: hasReachedLimit
              ? Color(0xff8E909F).withAlpha(80)
              : Color(0xff8E909F),
          size: 16,
        ),
        SizedBox(width: 6),
        Flexible(
          child: Text(
            LocaleKeys.couponExpiresOn(
              LocaleFormatter.date(expirationDate, locale),
            ),
            style: AppTextStyles(context).regular14.copyWith(
              color: hasReachedLimit
                  ? primaryTextColor.withAlpha(60)
                  : primaryTextColor,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
