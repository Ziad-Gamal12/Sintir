import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/card/teacher_wallet_animated_balance.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeacherCourseStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWorkspace/TeachespaceEnvironmentTheme.dart';
import 'package:sintir/locale_keys.dart';

/// "Available to withdraw" label, live balance and pending-payout line.
class TeacherWalletBalanceBlock extends StatelessWidget {
  const TeacherWalletBalanceBlock({super.key, required this.wallet});

  final TeacherWalletEntity wallet;

  @override
  Widget build(BuildContext context) {
    final tokens = WorkEnvironmentThemeExtension.of(context);
    final textStyles = AppTextStyles(context);
    final currencySymbol = LocaleKeys.currencyEgpSymbol;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          LocaleKeys.availableBalanceLabel,
          style: textStyles.regular12.copyWith(color: tokens.mutedText),
        ),
        const SizedBox(height: 4),
        TeacherWalletAnimatedBalance(
          balance: wallet.balance,
          currencySymbol: currencySymbol,
        ),
        if (wallet.payoutPending > 0) ...[
          const SizedBox(height: 4),
          Text(
            LocaleKeys.pendingWithdrawalAmount(
              TeacherWorkEnvironmentFormatters.formatAmount(
                wallet.payoutPending,
              ),
              currencySymbol,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: textStyles.regular12.copyWith(color: tokens.mutedText),
          ),
        ],
      ],
    );
  }
}
