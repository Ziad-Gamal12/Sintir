import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/search_and_filters/transaction_status_chip.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsStatusFilters extends StatelessWidget {
  const TransactionsStatusFilters({super.key, required this.state});
  final MyTransactionsState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyTransactionsCubit>();
    final theme = Theme.of(context);

    final filterItems = [
      (
        label: LocaleKeys.transactionsAll,
        count: state.count(null),
        selected: state.statusFilter == null,
        dotColor: null,
        onTap: () => cubit.setStatusFilter(null),
      ),
      (
        label: LocaleKeys.transactionsSuccess,
        count: state.count(TransactionsStatus.success),
        selected: state.statusFilter == TransactionsStatus.success,
        dotColor: TransactionsStyleMapper.statusColor(
          theme,
          TransactionsStatus.success,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.success),
      ),
      (
        label: LocaleKeys.transactionsPending,
        count: state.count(TransactionsStatus.pending),
        selected: state.statusFilter == TransactionsStatus.pending,
        dotColor: TransactionsStyleMapper.statusColor(
          theme,
          TransactionsStatus.pending,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.pending),
      ),
      (
        label: LocaleKeys.transactionsFailed,
        count: state.count(TransactionsStatus.failure),
        selected: state.statusFilter == TransactionsStatus.failure,
        dotColor: TransactionsStyleMapper.statusColor(
          theme,
          TransactionsStatus.failure,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.failure),
      ),
      (
        label: LocaleKeys.transactionsOther,
        count: state.count(TransactionsStatus.other),
        selected: state.statusFilter == TransactionsStatus.other,
        dotColor: TransactionsStyleMapper.statusColor(
          theme,
          TransactionsStatus.other,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.other),
      ),
    ];

    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
        itemCount: filterItems.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final item = filterItems[index];
          return TransactionStatusChip(
            key: ValueKey(item.label),
            label: item.label,
            count: item.count,
            selected: item.selected,
            dotColor: item.dotColor,
            onTap: item.onTap,
          );
        },
      ),
    );
  }
}
