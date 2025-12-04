import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TransactionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/TransactionsCubit/TransactionsCubit.dart';

class TransactionAmountAndStatus extends StatelessWidget {
  const TransactionAmountAndStatus({
    super.key,
    required this.transaction,
    required this.teacherId,
    required this.statusColor,
    required this.statusIcon,
  });

  final TransactionEntity transaction;
  final String teacherId;
  final Color statusColor;
  final IconData statusIcon;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TransactionsCubit, TransactionsState>(
      builder: (context, state) {
        final isLoading = state is ReconcileTransactionLoading &&
            state.transactionId == transaction.transactionId;
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Transaction Amount
            Text(
              'EGP ${transaction.amount?.toStringAsFixed(2) ?? '0.00'}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: statusColor,
              ),
            ),

            Column(
              children: [
                Icon(
                  statusIcon,
                  color: statusColor,
                  size: 24,
                ),
                const SizedBox(height: 4),
                if (isLoading)
                  SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: statusColor,
                      strokeWidth: 2.5,
                    ),
                  )
                else
                  IconButton(
                    onPressed: () {
                      context
                          .read<TransactionsCubit>()
                          .reconcileTransactionStatus(
                            userId: teacherId,
                            transaction: transaction,
                          );
                    },
                    icon: Icon(
                      Icons.refresh,
                      color: statusColor,
                      size: 24,
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
