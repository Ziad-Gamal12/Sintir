import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_status_badge.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';

class TransactionCardAmount extends StatelessWidget {
  const TransactionCardAmount({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final amount = transaction.amount == null
        ? '—'
        : LocaleFormatter.number(transaction.amount!, locale);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Directionality(
          textDirection: TextDirection.ltr,
          child: Text(
            '$amount ${_currency(transaction.currency, locale)}'.trim(),
            style: AppTextStyles(context).semiBold16.copyWith(
              color: transaction.status == TransactionsStatus.failure
                  ? TransactionsStyleMapper.statusColor(
                      theme,
                      transaction.status,
                    )
                  : theme.colorScheme.onSurface,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: 4),
        TransactionStatusBadge(status: transaction.status),
      ],
    );
  }

  String _currency(String? currency, String locale) =>
      switch ((currency, locale)) {
        ('EGP', 'ar') => 'ج.م',
        ('SAR', 'ar') => 'ر.س',
        (final value?, _) => value,
        _ => '',
      };
}
