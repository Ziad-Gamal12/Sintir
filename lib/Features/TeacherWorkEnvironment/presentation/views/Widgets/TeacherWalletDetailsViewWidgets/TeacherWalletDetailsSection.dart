import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/EarningsSummarySection/EarningsSummarySection.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/ExpandableWalletDetailsWidgets/expandable_wallet_details.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/ProfitSettlementNoteWidgets/ProfitSettlementNoteCard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWallet/CustomTeacherCardItem.dart';

class TeacherWalletDetailsSection extends StatelessWidget {
  const TeacherWalletDetailsSection({
    super.key,
    required this.wallet,
    required this.user,
    required this.colorScheme,
  });

  final TeacherWalletEntity wallet;
  final UserEntity user;
  final ColorScheme colorScheme;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomTeacherCardItem(
          wallet: wallet,
        ),
        Divider(
          color: colorScheme.onSurface.withValues(alpha: 0.1),
          thickness: 1,
          height: 40,
        ),
        EarningsSummarySection(
          teacherWallet: wallet,
        ),
        Divider(
          color: colorScheme.onSurface.withValues(alpha: 0.05),
          height: 20,
        ),
        ProfitSettlementNoteCard(),
        Divider(
          color: colorScheme.onSurface.withValues(alpha: 0.05),
          height: 20,
        ),
        ExpandableWalletDetails(
          wallet: wallet,
        )
        // Column(
        //   children: [
        //     TeacherWalletBalanceDetailsRow(
        //       icon: FontAwesomeIcons.calendar,
        //       title: LocaleKeys.createdDate,
        //       value: wallet.createdAt,
        //     ),
        //     Divider(
        //       color: colorScheme.onSurface.withValues(alpha: 0.05),
        //       height: 20,
        //     ),
        //     TeacherWalletBalanceDetailsRow(
        //       icon: FontAwesomeIcons.calendar,
        //       title: LocaleKeys.updatedDate,
        //       value: wallet.updatedAt,
        //     ),
        //     Divider(
        //       color: colorScheme.onSurface.withValues(alpha: 0.05),
        //       height: 20,
        //     ),
        //   ],
        // ),
      ],
    );
  }
}
