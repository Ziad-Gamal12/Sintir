import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_wallet_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

/// Loading state: the real wallet card shape, shimmering.
class TeacherWalletSkeleton extends StatelessWidget {
  const TeacherWalletSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: TeacherWalletCard(wallet: TeacherWalletEntity.empty()),
    );
  }
}
