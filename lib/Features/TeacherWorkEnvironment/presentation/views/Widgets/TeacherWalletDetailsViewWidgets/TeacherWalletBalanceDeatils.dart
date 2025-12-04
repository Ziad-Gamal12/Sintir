import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';

import 'teacher_wallet_balance_details_bottom.dart';
import 'teacher_wallet_balance_details_card.dart';

class TeacherWalletBalanceDetails extends StatelessWidget {
  const TeacherWalletBalanceDetails({super.key, required this.wallet});
  final TeacherWalletEntity wallet;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: AspectRatio(
        aspectRatio: 2 / 1.5,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Positioned.fill(
              child: TeacherWalletBalanceDetailsCard(
                wallet: wallet,
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: TeacherWalletBalanceDetailsBottom(wallet: wallet),
            ),
          ],
        ),
      ),
    );
  }
}
