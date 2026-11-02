import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/details_sheet/transactions_details_pane.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/list/transactions_scrollable_list.dart';

class MyTransactionsViewBody extends StatefulWidget {
  const MyTransactionsViewBody({super.key});

  @override
  State<MyTransactionsViewBody> createState() => _MyTransactionsViewBodyState();
}

class _MyTransactionsViewBodyState extends State<MyTransactionsViewBody> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  String _userId = '';
  TransactionEntity? _selected;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_paginate);
    _userId = getUserData().uid;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => context.read<MyTransactionsCubit>().getMyTransactions(
        userId: _userId,
        isPaginate: false,
      ),
    );
  }

  void _paginate() {
    if (!_scrollController.hasClients ||
        _scrollController.position.extentAfter > 240) {
      return;
    }
    final state = context.read<MyTransactionsCubit>().state;
    if (state.hasMore && !state.isLoading && !state.isPaginating) {
      context.read<MyTransactionsCubit>().getMyTransactions(
        userId: _userId,
        isPaginate: true,
      );
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) =>
      BlocBuilder<MyTransactionsCubit, MyTransactionsState>(
        builder: (context, state) {
          final wide = MediaQuery.sizeOf(context).width >= 900;
          final list = TransactionsScrollableList(
            state: state,
            searchController: _searchController,
            scrollController: _scrollController,
            onRefresh: () => context
                .read<MyTransactionsCubit>()
                .getMyTransactions(userId: _userId, isPaginate: false),
            onSearchChanged: context.read<MyTransactionsCubit>().search,
            onRetry: () => context
                .read<MyTransactionsCubit>()
                .getMyTransactions(userId: _userId, isPaginate: false),
            onClearFilters: context.read<MyTransactionsCubit>().clearFilters,
            onTransactionSelected: wide
                ? (transaction) => setState(() => _selected = transaction)
                : null,
          );
          return Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: wide ? 1280 : 720),
              child: wide
                  ? Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          Expanded(flex: 6, child: list),
                          const SizedBox(width: 16),
                          TransactionsDetailsPane(
                            transaction: _selected,
                            onClose: () => setState(() => _selected = null),
                          ),
                        ],
                      ),
                    )
                  : list,
            ),
          );
        },
      );
}
