import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactions/CheckTransactionStatus.dart';

class TransactionStatusBadge extends StatelessWidget {
  const TransactionStatusBadge(
      {super.key,
      required this.label,
      required this.color,
      required this.transaction,
      required this.teacherId});

  final String label;
  final Color color;
  final TransactionEntity transaction;
  final String teacherId;

  @override
  Widget build(BuildContext context) {
    final textStyles = AppTextStyles(context);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          decoration: BoxDecoration(
            color: color.withAlpha(30),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              ),
              const SizedBox(width: 6),
              Text(label, style: textStyles.semiBold11.copyWith(color: color)),
            ],
          ),
        ),
        const SizedBox(width: 8),
        CheckTransactionStatus(
            color: color, teacherId: teacherId, transaction: transaction)
      ],
    );
  }
}
