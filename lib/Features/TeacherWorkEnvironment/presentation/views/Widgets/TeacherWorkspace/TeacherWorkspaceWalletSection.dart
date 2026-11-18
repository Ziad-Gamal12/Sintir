// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_live_wallet_builder.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_wallet_card.dart';

class TeacherWorkEnvironmentWalletSection extends StatelessWidget {
  const TeacherWorkEnvironmentWalletSection({super.key});

  @override
  Widget build(BuildContext context) {
    return TeacherLiveWalletBuilder(
      builder: (context, wallet, staleNotice) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TeacherWalletCard(wallet: wallet),
          if (staleNotice != null) ...[const SizedBox(height: 8), staleNotice],
        ],
      ),
    );
  }
}
