import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_detail_row.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transaction_method_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsRows extends StatelessWidget {
  const TransactionDetailsRows({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final createdAt = transaction.createdAt;
    final date = createdAt == null
        ? null
        : intl.DateFormat.yMMMMEEEEd(locale).add_jm().format(createdAt);
    final rows = <Widget>[
      TransactionDetailRow(
        icon: Icons.tag,
        label: LocaleKeys.transactionsFullNumber,
        value: TransactionDisplayFormatters.fullId(transaction.transactionId),
        copy: true,
        ltr: true,
        grouped: true,
      ),
      if (date != null)
        TransactionDetailRow(
          icon: Icons.calendar_today_outlined,
          label: LocaleKeys.transactionsCreatedAt,
          value: date,
          grouped: true,
        ),
      TransactionDetailRow(
        icon: Icons.credit_card_outlined,
        label: LocaleKeys.transactionsPaymentMethod,
        value: TransactionMethodMapper.detailLabel(transaction.method),
        grouped: true,
      ),
      if (transaction.issuer?.isNotEmpty == true)
        TransactionDetailRow(
          icon: Icons.account_balance_outlined,
          label: LocaleKeys.transactionsIssuer,
          value: TransactionDisplayFormatters.issuerLabel(transaction.issuer!),
          grouped: true,
        ),
      if (transaction.mobileNumber?.isNotEmpty == true)
        TransactionDetailRow(
          icon: Icons.phone_iphone,
          label: LocaleKeys.transactionsPhone,
          value: TransactionDisplayFormatters.maskPhone(
            transaction.mobileNumber!,
          ),
          ltr: true,
          grouped: true,
        ),
      if (transaction.isReconciled != null)
        TransactionDetailRow(
          icon: Icons.verified_user_outlined,
          label: LocaleKeys.transactionsReconciliation,
          value: transaction.isReconciled!
              ? LocaleKeys.transactionsMatchedSuccess
              : LocaleKeys.transactionsMatchedFailed,
          valueColor: transaction.isReconciled!
              ? TransactionsStyleMapper.statusColor(
                  theme,
                  TransactionsStatus.success,
                )
              : theme.colorScheme.onSurfaceVariant,
          grouped: true,
        ),
      if (transaction.currency != null)
        TransactionDetailRow(
          icon: Icons.currency_exchange,
          label: LocaleKeys.transactionsCurrency,
          value: TransactionDisplayFormatters.currencyLabel(
            transaction.currency!,
          ),
          grouped: true,
        ),
    ];
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: TransactionsStyleMapper.cardBorder(theme)),
      ),
      child: Column(
        children: [
          for (var index = 0; index < rows.length; index++) ...[
            rows[index],
            if (index < rows.length - 1)
              Divider(
                height: 1,
                indent: 38,
                color: theme.dividerColor.withValues(alpha: .35),
              ),
          ],
        ],
      ),
    );
  }
}
