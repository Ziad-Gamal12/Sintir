import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TransactionAmountAndStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TransactionDetails.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TransactionStatusAndDate.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';

class TeachersTransactionsListViewItem extends StatelessWidget {
  const TeachersTransactionsListViewItem({
    super.key,
    required this.transaction,
    required this.teacherId,
  });

  final TransactionEntity transaction;
  final String teacherId;

  // Helper Methods (Kept in main class for centralizing status logic)
  Color _getStatusColor(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus == 'success' || lowerStatus == 'completed') {
      return Colors.green.shade600;
    } else if (lowerStatus == 'failed' || lowerStatus == 'rejected') {
      return Colors.red.shade600;
    }
    return Colors.orange.shade600;
  }

  IconData _getStatusIcon(String status) {
    final lowerStatus = status.toLowerCase();
    if (lowerStatus == 'success' || lowerStatus == 'completed') {
      return Icons.check_circle_outline;
    } else if (lowerStatus == 'failed' || lowerStatus == 'rejected') {
      return Icons.cancel_outlined;
    }
    return Icons.pending_outlined;
  }

  String _formatStatus(String status) {
    return status.toUpperCase();
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(transaction.status ?? '');
    final statusIcon = _getStatusIcon(transaction.status ?? "");
    final regularTextStyle = AppTextStyles(context).regular14;

    return BlocConsumer<WithDrawTeacherBalanceCubit,
        WithDrawTeacherBalanceState>(
      listener: (context, state) {
        if (state is ReconcileTransactionFailure &&
            state.transactionId == transaction.transactionId) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        } else if (state is ReconcileTransactionSuccess &&
            state.transactionId == transaction.transactionId) {
          CustomSnackBar.show(
            context,
            message: 'Transaction status updated successfully',
            type: SnackType.success,
          );
        }
      },
      builder: (context, state) {
        return Card(
          elevation: 4,
          margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TransactionAmountAndStatus(
                  transaction: transaction,
                  teacherId: teacherId,
                  statusColor: statusColor,
                  statusIcon: statusIcon,
                ),
                const SizedBox(height: 8),
                TransactionStatusAndDate(
                  transaction: transaction,
                  statusColor: statusColor,
                  formatStatus: _formatStatus,
                ),
                const Divider(height: 20, thickness: 0.5),
                TransactionDetails(
                  transaction: transaction,
                  textStyle: regularTextStyle,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
