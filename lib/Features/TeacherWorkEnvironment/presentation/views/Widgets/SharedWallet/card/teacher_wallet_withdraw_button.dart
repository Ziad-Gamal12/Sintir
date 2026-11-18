import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/WithDrawBalanceView.dart';
import 'package:sintir/locale_keys.dart';

/// Opens the withdraw screen. Only rendered for wallets that can withdraw;
/// the withdraw screen re-checks the live status itself.
class TeacherWalletWithdrawButton extends StatelessWidget {
  const TeacherWalletWithdrawButton({
    super.key,
    required this.wallet,
    this.expand = false,
  });

  final TeacherWalletEntity wallet;

  /// Stretch to the available width (large-text layout).
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final button = FilledButton(
      style: FilledButton.styleFrom(
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Colors.white,
        elevation: 0,
        minimumSize: const Size(0, 38),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsetsDirectional.symmetric(horizontal: 16),
      ),
      onPressed: () => GoRouter.of(
        context,
      ).push(WithDrawBalanceView.routeName, extra: wallet),
      child: Text(
        LocaleKeys.withdrawBalance,
        style: AppTextStyles(context).semiBold13.copyWith(color: Colors.white),
      ),
    );

    return expand ? SizedBox(width: double.infinity, child: button) : button;
  }
}
