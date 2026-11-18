import 'package:flutter/material.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_balance_block.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_card_header.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_withdraw_button.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_withdraw_unavailable_notice.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/utils/teacher_wallet_status_style.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletCard extends StatelessWidget {
  const TeacherWalletCard({super.key, required this.wallet});

  final TeacherWalletEntity wallet;

  static const double _minRowWidth = 280;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isLargeText = MediaQuery.textScalerOf(context).scale(1.0) >= 1.4;
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final status = wallet.walletStatus;

    final balance = TeacherWalletBalanceBlock(wallet: wallet);
    final Widget footer;
    if (!status.canWithdraw) {
      footer = Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          balance,
          const SizedBox(height: 14),
          TeacherWalletWithdrawUnavailableNotice(status: status),
        ],
      );
    } else {
      footer = LayoutBuilder(
        builder: (context, constraints) {
          final stacked = isLargeText || constraints.maxWidth < _minRowWidth;
          if (stacked) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                balance,
                const SizedBox(height: 12),
                TeacherWalletWithdrawButton(wallet: wallet, expand: true),
              ],
            );
          }
          return Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(child: balance),
              const SizedBox(width: 12),
              TeacherWalletWithdrawButton(wallet: wallet),
            ],
          );
        },
      );
    }

    return Semantics(
      container: true,
      liveRegion: true,
      label:
          '${LocaleKeys.academicWalletTitle}, ${status.label}, '
          '${LocaleKeys.availableBalanceLabel}: '
          '${TeacherWorkEnvironmentFormatters.formatAmount(wallet.balance)} '
          '${LocaleKeys.currencyEgpSymbol}',
      child: Container(
        width: double.infinity,
        padding: const EdgeInsetsDirectional.all(16),
        decoration: BoxDecoration(
          color: tokens.cardBackground,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: tokens.cardBorder),
          boxShadow: isDark
              ? const []
              : [
                  BoxShadow(
                    color: tokens.cardShadow,
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TeacherWalletCardHeader(status: status, isLargeText: isLargeText),
            const SizedBox(height: 16),

            if (reduceMotion)
              footer
            else
              AnimatedSize(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeOutCubic,
                alignment: AlignmentDirectional.topStart,
                child: footer,
              ),
          ],
        ),
      ),
    );
  }
}
