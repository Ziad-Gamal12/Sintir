import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';

class CheckTransactionStatus extends StatelessWidget {
  const CheckTransactionStatus({
    super.key,
    required this.color,
    required this.teacherId,
    required this.transaction,
  });

  final Color color;
  final String teacherId;
  final TransactionEntity transaction;

  @override
  Widget build(BuildContext context) {
    return BlocSelector<WithDrawTeacherBalanceCubit,
        WithDrawTeacherBalanceState, bool>(
      selector: (state) {
        return (state is ReconcileTransactionLoading &&
                state.transactionId == teacherId)
            ? true
            : false;
      },
      builder: (context, isLoading) {
        return SizedBox(
          width: 12,
          height: 12,
          child: isLoading
              ? CircularProgressIndicator(
                  color: color,
                  strokeWidth: 1.5,
                )
              : IconButton(
                  padding: EdgeInsets.zero,
                  onPressed: () {
                    context
                        .read<WithDrawTeacherBalanceCubit>()
                        .reconcileTransactionStatus(
                          userId: teacherId,
                          transaction: transaction,
                        );
                  },
                  icon: Icon(
                    Icons.refresh,
                    color: color,
                    size: 16,
                  ),
                ),
        );
      },
    );
  }
}
