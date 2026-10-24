import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberJoinedDateRow extends StatelessWidget {
  const SubscriberJoinedDateRow({super.key, required this.joinedDate});
  final DateTime joinedDate;
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    return Row(
      children: [
        Icon(
          Icons.calendar_today_rounded,
          size: 15,
          color: theme.colorScheme.onSurfaceVariant,
        ),
        SizedBox(
          width: 4,
        ),
        Text(
          '${LocaleKeys.subscriberJoinedDate}: ${DateFormat.yMMMMd(locale).format(joinedDate)}',
          style: AppTextStyles(context).regular12.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
        ),
      ],
    );
  }
}
