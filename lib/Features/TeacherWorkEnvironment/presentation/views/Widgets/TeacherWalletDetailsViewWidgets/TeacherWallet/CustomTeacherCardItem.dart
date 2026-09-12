import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWallet/CustomTeacherCardHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWallet/TeacherWalletAvailableBalance.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/TeacherWallet/TeacherWalletWithDrawButton.dart';

class CustomTeacherCardItem extends StatelessWidget {
  const CustomTeacherCardItem({super.key, required this.wallet});
  final TeacherWalletEntity? wallet;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    bool isDark = theme.brightness == Brightness.dark;
    return LayoutBuilder(builder: (context, constraints) {
      final isCompact = constraints.maxWidth < 360;

      return Container(
        padding: EdgeInsets.all(20),
        width: double.infinity,
        constraints: const BoxConstraints(
          minHeight: 222,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: theme.colorScheme.surface,
          border: Border.all(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.1),
          ),
        ),
        child: wallet != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: isCompact ? 14 : 20,
                children: [
                  CustomTeacherCardHeader(wallet: wallet),
                  TeacherWalletAvailableBalance(
                      isDark: isDark,
                      currency: wallet!.currency,
                      balance: wallet!.balance.toStringAsFixed(2),
                      theme: theme),
                  TeacherWalletWithDrawButton(isCompact: isCompact)
                ],
              )
            : Center(
                child: Text(
                  "No Wallet Data Available",
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                  ),
                ),
              ),
      );
    });
  }
}
