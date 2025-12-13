import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class TransactionStatusAndDate extends StatelessWidget {
  const TransactionStatusAndDate({
    super.key,
    required this.transaction,
    required this.statusColor,
    required this.formatStatus,
  });

  final TransactionEntity transaction;
  final Color statusColor;
  final String Function(String) formatStatus;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Status Badge Container
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: statusColor.withOpacity(0.15),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Text(
            formatStatus(transaction.status ?? 'PENDING'),
            style: TextStyle(
              color: statusColor,
              fontWeight: FontWeight.w600,
              fontSize: 12,
            ),
          ),
        ),
        // Transaction Date
        Text(
          DateFormat('MMM d, yyyy HH:mm')
              .format(transaction.createdAt ?? DateTime.now()),
          style: AppTextStyles(context).regular13,
        ),
      ],
    );
  }
}
