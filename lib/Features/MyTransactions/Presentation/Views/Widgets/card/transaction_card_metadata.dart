import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_reconciliation_badge.dart';
import 'package:sintir/locale_keys.dart';

class TransactionCardMetadata extends StatelessWidget {
  const TransactionCardMetadata({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final created = transaction.createdAt;
    final sameDay =
        created != null && DateUtils.isSameDay(created, DateTime.now());
    final previousDay =
        created != null &&
        DateUtils.isSameDay(
          created,
          DateTime.now().subtract(const Duration(days: 1)),
        );
    final dateLabel = created == null
        ? null
        : sameDay || previousDay
        ? intl.DateFormat.jm(locale).format(created)
        : intl.DateFormat.yMMMd(locale).format(created);
    return Wrap(
      alignment: WrapAlignment.spaceBetween,
      crossAxisAlignment: WrapCrossAlignment.center,
      spacing: 10,
      runSpacing: 8,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            transaction.mobileNumber == null
                ? LocaleKeys.transactionsPhoneUnavailable
                : TransactionDisplayFormatters.maskPhone(
                    transaction.mobileNumber!,
                  ),
            style: AppTextStyles(
              context,
            ).regular11.copyWith(color: theme.colorScheme.onSurfaceVariant),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        TransactionReconciliationBadge(isMatched: transaction.isReconciled),
        if (dateLabel != null)
          Text(
            dateLabel,
            style: AppTextStyles(
              context,
            ).regular11.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
      ],
    );
  }
}
