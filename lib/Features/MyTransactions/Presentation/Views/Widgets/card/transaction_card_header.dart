import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionCardHeader extends StatelessWidget {
  const TransactionCardHeader({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = TransactionsStyleMapper.methodColor(
      theme,
      transaction.method,
      transaction.status,
    );
    return Row(
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: color.withValues(
              alpha: theme.brightness == Brightness.dark ? .18 : .1,
            ),
            borderRadius: BorderRadius.circular(13),
          ),
          child: Icon(
            TransactionsStyleMapper.methodIcon(
              transaction.method,
              status: transaction.status,
            ),
            color: color,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _methodLabel(transaction.method),
                style: AppTextStyles(context).semiBold14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (transaction.issuer?.isNotEmpty == true)
                Text(
                  transaction.issuer!,
                  style: AppTextStyles(context).regular12.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
            ],
          ),
        ),
      ],
    );
  }

  String _methodLabel(String value) {
    final method = value.toLowerCase();
    if (method.contains('card') || method.contains('بطاقة')) {
      return LocaleKeys.transactionsBankCard;
    }
    if (method.contains('wallet') ||
        method.contains('mobile') ||
        method.contains('محفظ')) {
      return LocaleKeys.transactionsWallet;
    }
    if (method.contains('fawry') ||
        method.contains('outlet') ||
        method.contains('فوري')) {
      return LocaleKeys.transactionsFawry;
    }
    if (method.contains('cash') || method.contains('نقد')) {
      return LocaleKeys.transactionsCash;
    }
    if (method.contains('transfer') ||
        method.contains('instapay') ||
        method.contains('تحويل')) {
      return LocaleKeys.transactionsDirectTransfer;
    }
    return transaction.status == TransactionsStatus.other
        ? LocaleKeys.transactionsOther
        : value;
  }
}
