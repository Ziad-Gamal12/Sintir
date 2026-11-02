import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/filter_sheet/transactions_filter_sheet.dart';

Future<void> showTransactionsFilter(BuildContext context) async {
  final cubit = context.read<MyTransactionsCubit>();
  final filter = TransactionsFilterSheet(cubit: cubit);
  if (MediaQuery.sizeOf(context).width > 600) {
    await showDialog<void>(
      context: context,
      builder: (context) => Dialog(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 540, maxHeight: 720),
          child: filter,
        ),
      ),
    );
  } else {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => filter,
    );
  }
}
