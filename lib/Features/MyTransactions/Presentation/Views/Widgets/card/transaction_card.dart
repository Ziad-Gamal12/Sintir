import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_amount.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_footer.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_header.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_sheet.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
    this.onSelected,
  });

  final TransactionEntity transaction;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final status = _statusLabel(transaction.status);
    return Semantics(
      button: true,
      label:
          '${transaction.method}, ${transaction.amount == null ? '—' : LocaleFormatter.number(transaction.amount!, locale)}, $status',
      child: Material(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap:
              onSelected ?? () => showTransactionDetails(context, transaction),
          child: Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: theme.dividerColor.withValues(alpha: .24),
              ),
              boxShadow: theme.brightness == Brightness.light
                  ? [
                      BoxShadow(
                        color: theme.shadowColor.withValues(alpha: .04),
                        blurRadius: 8,
                        offset: const Offset(0, 3),
                      ),
                    ]
                  : null,
            ),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TransactionCardHeader(transaction: transaction),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: TransactionCardAmount(transaction: transaction),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Divider(
                    height: 1,
                    color: theme.dividerColor.withValues(alpha: .35),
                  ),
                ),
                TransactionCardFooter(transaction: transaction),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _statusLabel(TransactionsStatus? status) => switch (status) {
    TransactionsStatus.success => LocaleKeys.transactionsSuccess,
    TransactionsStatus.pending => LocaleKeys.transactionsPending,
    TransactionsStatus.failure => LocaleKeys.transactionsFailed,
    _ => LocaleKeys.transactionsOther,
  };
}
