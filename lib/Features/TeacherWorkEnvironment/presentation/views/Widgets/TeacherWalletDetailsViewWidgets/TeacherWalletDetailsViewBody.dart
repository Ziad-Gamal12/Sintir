// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_live_wallet_builder.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsSection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactions/TeachersTransactionsListView.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletTransactions/TeachersTransactionsListViewHeader.dart';
import 'package:sintir/constant.dart';

/// Wallet details: the live wallet section on top, then transactions.
///
/// Only the wallet sliver listens to wallet updates; the transactions list
/// has its own stream and is not rebuilt when the wallet changes.
class TeacherWalletDetailsViewBody extends StatelessWidget {
  const TeacherWalletDetailsViewBody({super.key, required this.teacherId});

  final String teacherId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: TeacherLiveWalletBuilder(
              builder: (context, wallet, staleNotice) =>
                  TeacherWalletDetailsSection(
                    wallet: wallet,
                    staleNotice: staleNotice,
                  ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 20)),
          SliverToBoxAdapter(child: TeachersTransactionsListViewHeader()),
          TeachersTransactionsListView(teacherId: teacherId),
          const SliverToBoxAdapter(child: SizedBox(height: 100)),
        ],
      ),
    );
  }
}
