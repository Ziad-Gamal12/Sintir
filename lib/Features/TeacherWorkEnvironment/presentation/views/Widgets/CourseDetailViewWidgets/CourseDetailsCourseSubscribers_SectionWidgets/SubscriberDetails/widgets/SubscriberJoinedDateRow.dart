import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class SubscriberJoinedDateRow extends StatelessWidget {
  const SubscriberJoinedDateRow({super.key, required this.joinedDate});
  final DateTime joinedDate;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).toString();
    return Row(children: [
      Icon(Icons.calendar_month,
          size: 16, color: theme.colorScheme.onSurfaceVariant),
      const SizedBox(width: 6),
      Expanded(
          child: Text(
        '${LocaleKeys.subscriberJoinedDate}: ${LocaleFormatter.longDate(joinedDate, locale)}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTextStyles(context)
            .regular12
            .copyWith(color: theme.colorScheme.onSurfaceVariant),
      )),
    ]);
  }
}
