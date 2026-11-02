import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class TransactionDetailsHeader extends StatelessWidget {
  const TransactionDetailsHeader({
    super.key,
    required this.transaction,
    required this.onClose,
  });

  final TransactionEntity transaction;
  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      children: [
        IconButton.filledTonal(
          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
          onPressed: onClose,
          icon: const Icon(Icons.close_rounded),
        ),
        const SizedBox(width: 10),
        Icon(Icons.receipt_long_outlined, color: theme.colorScheme.primary),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                LocaleKeys.transactionsDetails,
                style: AppTextStyles(context).semiBold20,
              ),
              Text(
                '${LocaleKeys.transactionsSystemReference}: #${transaction.transactionId}',
                style: AppTextStyles(
                  context,
                ).regular11.copyWith(color: theme.colorScheme.onSurfaceVariant),
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
