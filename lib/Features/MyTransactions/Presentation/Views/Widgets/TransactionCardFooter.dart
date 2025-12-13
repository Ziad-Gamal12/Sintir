// transaction_card_footer.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Domain/helpers/transaction_helpers.dart';
import 'package:sintir/locale_keys.dart';

class TransactionCardFooter extends StatelessWidget {
  const TransactionCardFooter({super.key, required this.transactionEntity});

  final TransactionEntity transactionEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final statusColor = getStatusColor(context, transactionEntity.status);

    final dateString = DateFormat('MMM d, yyyy')
        .format(transactionEntity.createdAt ?? DateTime.now());
    final timeString = DateFormat('h:mm a')
        .format(transactionEntity.createdAt ?? DateTime.now());

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            // Amount (Largest and Color-Coded)
            Text(
              formatAmount(
                  transactionEntity.amount, transactionEntity.currency),
              style: textStyles.regular14.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w900,
                color: statusColor,
                letterSpacing: -0.5,
              ),
            ),

            // Creation Date & Time
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  dateString,
                  style: textStyles.regular14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: theme.textTheme.bodyLarge!.color!.withOpacity(0.8),
                  ),
                ),
                Text(
                  timeString,
                  style: textStyles.regular14.copyWith(
                    fontSize: 11,
                    color: theme.textTheme.bodySmall!.color!.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ],
        ),

        // Transaction ID (Optional)
        if (transactionEntity.transactionId != null)
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${LocaleKeys.transactionId}: ${transactionEntity.transactionId!}',
                style: textStyles.regular14.copyWith(
                  color: theme.textTheme.bodySmall!.color!.withOpacity(0.4),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
