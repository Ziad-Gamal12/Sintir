import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/styles/transactions_style_mapper.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/search_and_filters/transaction_status_chip.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/locale_keys.dart';

class TransactionsStatusFilters extends StatelessWidget {
  const TransactionsStatusFilters({super.key, required this.state});
  final MyTransactionsState state;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MyTransactionsCubit>();
    final chips = <Widget>[
      TransactionStatusChip(
        label: LocaleKeys.transactionsAll,
        count: state.count(null),
        selected: state.statusFilter == null,
        onTap: () => cubit.setStatusFilter(null),
      ),
      TransactionStatusChip(
        label: LocaleKeys.transactionsSuccess,
        count: state.count(TransactionsStatus.success),
        selected: state.statusFilter == TransactionsStatus.success,
        dotColor: TransactionsStyleMapper.statusColor(
          Theme.of(context),
          TransactionsStatus.success,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.success),
      ),
      TransactionStatusChip(
        label: LocaleKeys.transactionsPending,
        count: state.count(TransactionsStatus.pending),
        selected: state.statusFilter == TransactionsStatus.pending,
        dotColor: TransactionsStyleMapper.statusColor(
          Theme.of(context),
          TransactionsStatus.pending,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.pending),
      ),
      TransactionStatusChip(
        label: LocaleKeys.transactionsFailed,
        count: state.count(TransactionsStatus.failure),
        selected: state.statusFilter == TransactionsStatus.failure,
        dotColor: TransactionsStyleMapper.statusColor(
          Theme.of(context),
          TransactionsStatus.failure,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.failure),
      ),
      TransactionStatusChip(
        label: LocaleKeys.transactionsOther,
        count: state.count(TransactionsStatus.other),
        selected: state.statusFilter == TransactionsStatus.other,
        dotColor: TransactionsStyleMapper.statusColor(
          Theme.of(context),
          TransactionsStatus.other,
        ),
        onTap: () => cubit.setStatusFilter(TransactionsStatus.other),
      ),
    ];
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SizedBox(
        height: 42,
        child: ListView(scrollDirection: Axis.horizontal, children: chips),
      ),
    );
  }
}
