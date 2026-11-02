import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/search_and_filters/transaction_search_field.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/search_and_filters/transactions_filter_button.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/search_and_filters/transactions_status_filters.dart';

class TransactionsSearchAndFilters extends StatelessWidget {
  const TransactionsSearchAndFilters({
    super.key,
    required this.state,
    required this.searchController,
    required this.onSearchChanged,
  });

  final MyTransactionsState state;
  final TextEditingController searchController;
  final ValueChanged<String> onSearchChanged;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        children: [
          Expanded(
            child: TransactionSearchField(
              controller: searchController,
              onChanged: onSearchChanged,
            ),
          ),
          const SizedBox(width: 8),
          TransactionsFilterButton(isActive: state.hasActiveFilters),
        ],
      ),
      const SizedBox(height: 12),
      TransactionsStatusFilters(state: state),
    ],
  );
}
