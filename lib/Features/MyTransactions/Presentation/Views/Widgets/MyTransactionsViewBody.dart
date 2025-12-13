import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Manager/my_transactions_cubit/my_transactions_cubit.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/MyTransactionListView.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/MyTransactionLoadingListView.dart';
import 'package:sintir/locale_keys.dart';

class MyTransactionsViewBody extends StatefulWidget {
  const MyTransactionsViewBody({super.key});

  @override
  State<MyTransactionsViewBody> createState() => _MyTransactionsViewBodyState();
}

class _MyTransactionsViewBodyState extends State<MyTransactionsViewBody> {
  late ScrollController scrollController;
  bool hasMore = true;
  List<TransactionEntity> transactions = [];
  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    String userUID = getUserData().uid;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MyTransactionsCubit>().getMyTransactions(
            userId: userUID,
            isPaginate: false,
          );
      scrollController.addListener(() {
        if (scrollController.position.pixels >=
                scrollController.position.maxScrollExtent - 200 &&
            hasMore &&
            context.read<MyTransactionsCubit>().state
                is! GetMyTransactionsLoading) {
          if (hasMore) {
            context.read<MyTransactionsCubit>().getMyTransactions(
                  userId: userUID,
                  isPaginate: true,
                );
          }
        }
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MyTransactionsCubit, MyTransactionsState>(
      listener: (context, state) {
        if (state is GetMyTransactionsSuccess) {
          if (state.getMyTransactionsResponseEntity.isPaginate == true) {
            transactions
                .addAll(state.getMyTransactionsResponseEntity.transactions);
          } else {
            transactions = state.getMyTransactionsResponseEntity.transactions;
          }
          hasMore = state.getMyTransactionsResponseEntity.hasMore;
        }
      },
      builder: (context, state) {
        if (state is GetMyTransactionsFailure) {
          return CustomErrorWidget(errormessage: state.errmessage);
        } else if (state is GetMyTransactionsLoading &&
            state.isPaginate == false) {
          return const MyTransactionLoadingListView();
        } else if (state is GetMyTransactionsSuccess && transactions.isEmpty) {
          return CustomEmptyWidget(text: LocaleKeys.emptyContent);
        } else {
          return CustomScrollView(
            controller: scrollController,
            slivers: [
              MyTransactionSliverListView(
                transactions: transactions,
              ),
              SliverToBoxAdapter(
                child: state is GetMyTransactionsLoading &&
                        state.isPaginate == true
                    ? const MyTransactionLoadingListView()
                    : const SizedBox(),
              ),
            ],
          );
        }
      },
    );
  }
}
