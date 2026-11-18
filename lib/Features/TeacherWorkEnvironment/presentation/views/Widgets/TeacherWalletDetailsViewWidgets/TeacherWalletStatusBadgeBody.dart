// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/utils/teacher_wallet_status_style.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkenvironmentviewWidgets/TeacherWorkEnvironmentTheme.dart';

/// Compact dot + label status, used in the wallet details rows. Shares its
/// labels and colors with the wallet card's status pill.
class TeacherWalletStatusBadgeBody extends StatelessWidget {
  const TeacherWalletStatusBadgeBody({super.key, required this.status});

  final String? status;

  @override
  Widget build(BuildContext context) {
    final walletStatus = TeacherWalletStatus.fromRaw(status);
    final color = walletStatus.foreground(
      WorkEnvironmentThemeExtension.of(context),
    );

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Icons.circle, color: color, size: 8),
        const SizedBox(width: 6),
        Text(
          walletStatus.label,
          style: AppTextStyles(context).semiBold12.copyWith(color: color),
        ),
      ],
    );
  }
}
