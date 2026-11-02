import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/card/transaction_display_formatters.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transaction_method_mapper.dart';

class TransactionCardHeader extends StatelessWidget {
  const TransactionCardHeader({super.key, required this.transaction});
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = TransactionMethodMapper.color(
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
            TransactionMethodMapper.icon(
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
                TransactionMethodMapper.label(transaction.method),
                style: AppTextStyles(context).semiBold14,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (transaction.issuer?.isNotEmpty == true)
                Text(
                  TransactionDisplayFormatters.issuerLabel(transaction.issuer!),
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
}
