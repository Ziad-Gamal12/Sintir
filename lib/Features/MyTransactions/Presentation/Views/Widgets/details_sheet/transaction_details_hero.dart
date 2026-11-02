import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_status_pills.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsHero extends StatelessWidget {
  const TransactionDetailsHero({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final locale = Localizations.localeOf(context).languageCode;
    final amount = transaction.amount == null
        ? '—'
        : TransactionDisplayFormatters.fixedAmount(transaction.amount!, locale);
    final currency = transaction.currency == 'EGP'
        ? (locale == 'ar' ? 'ج.م' : 'EGP')
        : transaction.currency == 'SAR'
        ? (locale == 'ar' ? 'ر.س' : 'SAR')
        : transaction.currency ?? '';
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            TransactionsStyleMapper.primary(theme).withValues(alpha: .13),
            TransactionsStyleMapper.primary(theme).withValues(alpha: .04),
          ],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Text(
            transaction.status == TransactionsStatus.failure
                ? LocaleKeys.transactionsAmount
                : LocaleKeys.transactionsTotalCollected,
            style: AppTextStyles(
              context,
            ).regular12.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 4),
          Directionality(
            textDirection: TextDirection.ltr,
            child: Text(
              '$amount $currency'.trim(),
              style: AppTextStyles(context).bold30.copyWith(
                color: theme.brightness == Brightness.dark
                    ? const Color(0xFF3B82F6)
                    : TransactionsStyleMapper.brand,
              ),
            ),
          ),
          const SizedBox(height: 12),
          TransactionDetailsStatusPills(
            status: transaction.status,
            reconciled: transaction.isReconciled,
          ),
        ],
      ),
    );
  }
}
