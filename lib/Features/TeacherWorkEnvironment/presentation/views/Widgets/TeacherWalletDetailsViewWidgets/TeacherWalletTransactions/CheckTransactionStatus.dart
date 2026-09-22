import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';

class CheckTransactionStatus extends StatelessWidget {
  const CheckTransactionStatus(
      {super.key, required this.color, required this.transaction});
  final Color color;
  final TransactionEntity transaction;
  @override
  Widget build(BuildContext context) {
    if (transaction.status != TransactionsStatus.pending)
      return const SizedBox.shrink();
    return BlocSelector<WithDrawTeacherBalanceCubit,
            WithDrawTeacherBalanceState, bool>(
        selector: (state) =>
            state is ReconcileTransactionLoading &&
            state.transactionId == transaction.transactionId,
        builder: (context, isLoading) => SizedBox(
            width: 32,
            height: 32,
            child: isLoading
                ? Padding(
                    padding: const EdgeInsets.all(8),
                    child: CircularProgressIndicator(
                        color: color, strokeWidth: 1.5))
                : IconButton(
                    tooltip: 'Check payout status',
                    padding: EdgeInsets.zero,
                    onPressed: () => context
                        .read<WithDrawTeacherBalanceCubit>()
                        .reconcileWithdrawal(
                            withdrawalId: transaction.transactionId),
                    icon: Icon(Icons.refresh, color: color, size: 18))));
  }
}
