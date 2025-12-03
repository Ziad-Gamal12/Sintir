import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletBalanceDeatils.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWalletDetailsViewBodyWalletCardHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/teacher_wallet_balance_details_row.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/CustomTeacherCardItem.dart';
import 'package:sintir/locale_keys.dart';

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
        TeacherWalletDetailsViewBodyWalletCardHeader(
          status: wallet.status,
        ),
        CustomTeacherCardItem(
          user: user,
        ),
        Divider(
          // 1. Themed Divider
          color: colorScheme.onSurface.withOpacity(0.1),
          thickness: 1,
          height: 40,
        ),
        TeacherWalletBalanceDetails(
          wallet: wallet,
        ),
        Divider(
          // 3. Themed Divider
          color: colorScheme.onSurface.withOpacity(0.05),
          height: 20,
        ),
        Column(
          children: [
            TeacherWalletBalanceDetailsRow(
              icon: Icons.calendar_month_outlined,
              title: LocaleKeys.createdDate,
              value: wallet.createdAt,
            ),
            Divider(
              color: colorScheme.onSurface.withOpacity(0.05),
              height: 20,
            ),
            TeacherWalletBalanceDetailsRow(
              icon: Icons.calendar_month_outlined,
              title: LocaleKeys.updatedDate,
              value: wallet.updatedAt,
            ),
            Divider(
              color: colorScheme.onSurface.withOpacity(0.05),
              height: 20,
            ),
          ],
        ),
      ],
    );
  }
}
