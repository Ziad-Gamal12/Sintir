import 'package:flutter/material.dart';
import 'package:sintir/Features/MyTransactions/Presentation/Views/Widgets/states/transaction_skeleton_card.dart';

class TransactionsLoadingSliver extends StatelessWidget {
  const TransactionsLoadingSliver({super.key});

  @override
  Widget build(BuildContext context) => SliverList.builder(
    itemCount: 4,
    itemBuilder: (context, index) => const TransactionSkeletonCard(),
  );
}
