import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';

import 'teacher_wallet_balance_details_row.dart';

class TeacherWalletBalanceDetailsBottom extends StatelessWidget {
  final TeacherWalletEntity? wallet;

  const TeacherWalletBalanceDetailsBottom({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey.shade100, width: 1),
      ),
      child: Column(
        children: [
          TeacherWalletBalanceDetailsRow(
            icon: Icons.show_chart_outlined,
            title: "الرصيد الكلى",
            value: "${wallet?.totalEarned ?? 0} EGP",
          ),
          Divider(color: Colors.grey.shade300, height: 20),
          TeacherWalletBalanceDetailsRow(
            icon: FontAwesomeIcons.clock,
            title: "الرصيد المعلق",
            value: "${wallet?.payoutPending ?? 0} EGP",
          ),
          Divider(color: Colors.grey.shade300, height: 20),
          TeacherWalletBalanceDetailsRow(
            icon: FontAwesomeIcons.wallet,
            title: "العملة",
            value: wallet?.currency ?? "EGP",
          ),
        ],
      ),
    );
  }
}
