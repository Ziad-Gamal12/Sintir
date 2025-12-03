import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/locale_keys.dart';

import 'teacher_wallet_balance_details_row.dart';

class TeacherWalletBalanceDetailsBottom extends StatelessWidget {
  final TeacherWalletEntity? wallet;

  const TeacherWalletBalanceDetailsBottom({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.cardColor, // يعتمد على theme
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(
          color: theme.dividerColor, // يعتمد على theme
          width: 1,
        ),
      ),
      child: Column(
        children: [
          TeacherWalletBalanceDetailsRow(
            icon: Icons.show_chart_outlined,
            title: LocaleKeys.totalEarned,
            value: "${wallet?.totalEarned.toStringAsFixed(2) ?? 0} EGP",
          ),
          Divider(color: theme.dividerColor, height: 20),
          TeacherWalletBalanceDetailsRow(
            icon: FontAwesomeIcons.clock,
            title: LocaleKeys.pendingBalance,
            value: "${wallet?.payoutPending.toStringAsFixed(2) ?? 0} EGP",
          ),
          Divider(color: theme.dividerColor, height: 20),
          TeacherWalletBalanceDetailsRow(
            icon: FontAwesomeIcons.wallet,
            title: LocaleKeys.currency,
            value: wallet?.currency ?? "EGP",
          ),
        ],
      ),
    );
  }
}
