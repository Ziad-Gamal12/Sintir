import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/MyTransactions/Domain/helpers/transaction_helpers.dart';
import 'package:sintir/locale_keys.dart';

class TransactionCardHeader extends StatelessWidget {
  const TransactionCardHeader({super.key, required this.transactionEntity});

  final TransactionEntity transactionEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final statusColor = getStatusColor(context, transactionEntity.status);

    final mainDisplayTitle = transactionEntity.issuer?.isNotEmpty == true
        ? transactionEntity.issuer!
        : transactionEntity.method;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Icon for Method
        Icon(
          getMethodIcon(transactionEntity.method),
          color: theme.primaryColor,
          size: 24,
        ),
        const SizedBox(width: 16),

        // Transaction Title (Issuer/Method)
        Expanded(
          child: Text(
            mainDisplayTitle,
            style: textStyles.regular14.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ),

        // Status Badge
        Container(
          margin: const EdgeInsets.only(left: 8),
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            transactionEntity.status ?? LocaleKeys.notAvailable,
            style: textStyles.regular14.copyWith(
              color: statusColor,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ),
      ],
    );
  }
}
