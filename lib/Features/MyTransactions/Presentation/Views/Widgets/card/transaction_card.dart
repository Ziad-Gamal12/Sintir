import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_amount.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_footer.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_card_header.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_sheet.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transaction_method_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionCard extends StatefulWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
    this.onSelected,
  });

  final TransactionEntity transaction;
  final VoidCallback? onSelected;

  @override
  State<TransactionCard> createState() => _TransactionCardState();
}

class _TransactionCardState extends State<TransactionCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final transaction = widget.transaction;
    final status = _statusLabel(transaction.status);
    return Semantics(
      button: true,
      label:
          '${TransactionMethodMapper.label(transaction.method)}, ${transaction.amount == null ? '—' : TransactionDisplayFormatters.fixedAmount(transaction.amount!, locale)}, $status',
      child: AnimatedScale(
        scale: _pressed ? .98 : 1,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Material(
          color: TransactionsStyleMapper.cardSurface(theme),
          borderRadius: BorderRadius.circular(16),
          child: InkWell(
            borderRadius: BorderRadius.circular(16),
            onTapDown: (_) => setState(() => _pressed = true),
            onTapUp: (_) => setState(() => _pressed = false),
            onTapCancel: () => setState(() => _pressed = false),
            onTap:
                widget.onSelected ??
                () => showTransactionDetails(context, transaction),
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: TransactionsStyleMapper.cardBorder(theme),
                ),
                boxShadow: theme.brightness == Brightness.light
                    ? [
                        BoxShadow(
                          color: theme.shadowColor.withValues(alpha: .04),
                          blurRadius: 12,
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
