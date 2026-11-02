import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/list/transactions_list_item.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/states/transactions_empty_state.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/states/transactions_error_state.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/states/transactions_loading_sliver.dart';

class TransactionsResultsSliver extends StatelessWidget {
  const TransactionsResultsSliver({
    super.key,
    required this.state,
    required this.onRetry,
    required this.onClearFilters,
    this.onTransactionSelected,
  });

  final MyTransactionsState state;
  final VoidCallback onRetry;
  final VoidCallback onClearFilters;
  final ValueChanged<TransactionEntity>? onTransactionSelected;

  @override
  Widget build(BuildContext context) {
    if (state.isLoading && state.transactions.isEmpty) {
      return const TransactionsLoadingSliver();
    }
    if (state.error != null && state.transactions.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: TransactionsErrorState(message: state.error!, onRetry: onRetry),
      );
    }
    final items = state.displayItems;
    if (items.isEmpty) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: TransactionsEmptyState(
          hasTransactions: state.transactions.isNotEmpty,
          hasFilters: state.hasActiveFilters,
          onClearFilters: onClearFilters,
        ),
      );
    }
    return SliverList.builder(
      itemCount: items.length,
      itemBuilder: (context, index) => TransactionsListItem(
        item: items[index],
        onTransactionSelected: onTransactionSelected,
      ),
    );
  }
}
