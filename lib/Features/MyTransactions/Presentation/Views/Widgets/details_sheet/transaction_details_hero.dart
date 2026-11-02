import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transaction_details_status_pills.dart';
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
        : LocaleFormatter.number(transaction.amount!, locale);
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
            theme.colorScheme.primary.withValues(alpha: .13),
            theme.colorScheme.primary.withValues(alpha: .04),
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
              style: AppTextStyles(
                context,
              ).bold30.copyWith(color: theme.colorScheme.onSurface),
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
