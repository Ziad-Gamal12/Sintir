// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/teacher_wallet_card.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/EarningsSummarySection/EarningsSummarySection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/ExpandableWalletDetailsWidgets/expandable_wallet_details.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/ProfitSettlementNoteWidgets/ProfitSettlementNoteCard.dart';

class TeacherWalletDetailsSection extends StatelessWidget {
  const TeacherWalletDetailsSection({
    super.key,
    required this.wallet,
    this.staleNotice,
  });

  final TeacherWalletEntity wallet;

  /// Shown under the card when live updates stopped.
  final Widget? staleNotice;

  @override
  Widget build(BuildContext context) {
    final onSurface = Theme.of(context).colorScheme.onSurface;

    return Column(
      children: [
        TeacherWalletCard(wallet: wallet),
        if (staleNotice != null) ...[const SizedBox(height: 8), staleNotice!],
        Divider(
          color: onSurface.withValues(alpha: 0.1),
          thickness: 1,
          height: 40,
        ),
        EarningsSummarySection(teacherWallet: wallet),
        Divider(color: onSurface.withValues(alpha: 0.05), height: 20),
        ProfitSettlementNoteCard(),
        Divider(color: onSurface.withValues(alpha: 0.05), height: 20),
        ExpandableWalletDetails(wallet: wallet),
      ],
    );
  }
}
