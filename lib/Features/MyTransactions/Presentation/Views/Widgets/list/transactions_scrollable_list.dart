import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/header/transactions_header.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/list/transactions_results_sliver.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/search_and_filters/transactions_search_and_filters.dart';

class TransactionsScrollableList extends StatelessWidget {
  const TransactionsScrollableList({
    super.key,
    required this.state,
    required this.searchController,
    required this.scrollController,
    required this.onRefresh,
    required this.onSearchChanged,
    required this.onRetry,
    required this.onClearFilters,
    this.onTransactionSelected,
  });

  final MyTransactionsState state;
  final TextEditingController searchController;
  final ScrollController scrollController;
  final Future<void> Function() onRefresh;
  final ValueChanged<String> onSearchChanged;
  final VoidCallback onRetry, onClearFilters;
  final ValueChanged<TransactionEntity>? onTransactionSelected;

  @override
  Widget build(BuildContext context) => RefreshIndicator(
    onRefresh: onRefresh,
    child: CustomScrollView(
      controller: scrollController,
      slivers: [
        SliverPadding(
          padding: const EdgeInsetsDirectional.fromSTEB(16, 16, 16, 8),
          sliver: SliverToBoxAdapter(
            child: Column(
              children: [
                TransactionsHeader(transactions: state.filteredTransactions),
                const SizedBox(height: 18),
                TransactionsSearchAndFilters(
                  state: state,
                  searchController: searchController,
                  onSearchChanged: onSearchChanged,
                ),
              ],
            ),
          ),
        ),
        TransactionsResultsSliver(
          state: state,
          onRetry: onRetry,
          onClearFilters: onClearFilters,
          onTransactionSelected: onTransactionSelected,
        ),
        if (state.isPaginating)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Center(child: CircularProgressIndicator()),
            ),
          ),
      ],
    ),
  );
}
