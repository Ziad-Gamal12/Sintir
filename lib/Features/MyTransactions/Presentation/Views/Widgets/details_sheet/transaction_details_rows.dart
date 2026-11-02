import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/PaymentStatusPalette.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_detail_row.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsRows extends StatelessWidget {
  const TransactionDetailsRows({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = PaymentStatusPalette.forTheme(theme);
    final locale = Localizations.localeOf(context).languageCode;
    final createdAt = transaction.createdAt;
    final date = createdAt == null
        ? null
        : intl.DateFormat.yMMMMEEEEd(locale).add_jm().format(createdAt);
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest.withValues(alpha: .55),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          TransactionDetailRow(
            icon: Icons.tag,
            label: LocaleKeys.transactionsFullNumber,
            value: transaction.transactionId,
            copy: true,
            ltr: true,
          ),
          if (date != null)
            TransactionDetailRow(
              icon: Icons.calendar_today_outlined,
              label: LocaleKeys.transactionsCreatedAt,
              value: date,
            ),
          TransactionDetailRow(
            icon: Icons.credit_card_outlined,
            label: LocaleKeys.transactionsPaymentMethod,
            value: TransactionDisplayFormatters.methodLabel(transaction.method),
          ),
          if (transaction.issuer?.isNotEmpty == true)
            TransactionDetailRow(
              icon: Icons.account_balance_outlined,
              label: LocaleKeys.transactionsIssuer,
              value: transaction.issuer!,
            ),
          if (transaction.mobileNumber?.isNotEmpty == true)
            TransactionDetailRow(
              icon: Icons.phone_iphone,
              label: LocaleKeys.transactionsPhone,
              value: TransactionDisplayFormatters.maskPhone(
                transaction.mobileNumber!,
              ),
              ltr: true,
            ),
          if (transaction.isReconciled != null)
            TransactionDetailRow(
              icon: Icons.verified_user_outlined,
              label: LocaleKeys.transactionsReconciliation,
              value: transaction.isReconciled!
                  ? LocaleKeys.transactionsMatchedSuccess
                  : LocaleKeys.transactionsMatchedFailed,
              valueColor: transaction.isReconciled!
                  ? colors.success
                  : colors.information,
            ),
          if (transaction.currency != null)
            TransactionDetailRow(
              icon: Icons.currency_exchange,
              label: LocaleKeys.transactionsCurrency,
              value: transaction.currency == 'EGP'
                  ? LocaleKeys.transactionsCurrencyEgp
                  : transaction.currency == 'SAR'
                  ? LocaleKeys.transactionsCurrencySar
                  : transaction.currency!,
            ),
        ],
      ),
    );
  }
}
