import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDayGroupHeader extends StatelessWidget {
  const TransactionDayGroupHeader({super.key, required this.group});
  final TransactionDayGroup group;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(20, 18, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Text(
              _title(locale),
              style: AppTextStyles(context).semiBold14,
            ),
          ),
          Text(
            LocaleKeys.transactionsCountValue(
              group.transactions.length,
              locale,
            ),
            style: AppTextStyles(
              context,
            ).regular11.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          if (group.total != null) ...[
            const SizedBox(width: 8),
            Directionality(
              textDirection: TextDirection.ltr,
              child: Text(
                '${LocaleFormatter.number(group.total!, locale)} ${group.currency}',
                style: AppTextStyles(
                  context,
                ).regular11.copyWith(color: theme.colorScheme.primary),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _title(String locale) {
    final date = group.date;
    if (date.year == 1) return LocaleKeys.transactionsOlder;
    if (DateUtils.isSameDay(date, DateTime.now())) {
      return LocaleKeys.transactionsToday;
    }
    if (DateUtils.isSameDay(
      date,
      DateTime.now().subtract(const Duration(days: 1)),
    )) {
      return LocaleKeys.transactionsYesterday;
    }
    return intl.DateFormat('MMMM yyyy', locale).format(date);
  }
}
