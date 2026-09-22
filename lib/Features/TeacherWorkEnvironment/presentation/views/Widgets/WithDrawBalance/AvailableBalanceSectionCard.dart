import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class AvailableBalanceSectionCard extends StatelessWidget {
  const AvailableBalanceSectionCard(
      {super.key, required this.availableBalance});
  final double availableBalance;

  @override
  Widget build(BuildContext context) {
    final dark = Theme.of(context).brightness == Brightness.dark;
    final styles = AppTextStyles(context);
    final foreground = dark ? Colors.white : const Color(0xFF172036);
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: dark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(18),
        border:
            Border.all(color: dark ? Colors.white12 : const Color(0xFFDDE5F0)),
        boxShadow: dark
            ? null
            : const [
                BoxShadow(
                    color: Color(0x0A172036),
                    blurRadius: 12,
                    offset: Offset(0, 4))
              ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(
              padding: const EdgeInsets.all(9),
              decoration: BoxDecoration(
                  color: const Color(0xFFEAF0FF),
                  borderRadius: BorderRadius.circular(11)),
              child: const Icon(Icons.account_balance_wallet_outlined,
                  color: Color(0xFF4169E2), size: 20)),
          const SizedBox(width: 10),
          Expanded(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                Text(LocaleKeys.availableForWithdrawalLabel,
                    style: styles.semiBold14.copyWith(color: foreground)),
                const SizedBox(height: 2),
                Text(LocaleKeys.withdrawalBalanceUpdated,
                    style: styles.regular11.copyWith(
                        color:
                            dark ? Colors.white60 : const Color(0xFF71809A))),
              ])),
        ]),
        const SizedBox(height: 18),
        Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          Text(availableBalance.toStringAsFixed(2),
              textDirection: TextDirection.ltr,
              style: styles.bold32.copyWith(color: foreground, height: 1)),
          const SizedBox(width: 6),
          Padding(
              padding: const EdgeInsets.only(bottom: 3),
              child: Text(LocaleKeys.currencyEGP,
                  style:
                      styles.bold14.copyWith(color: const Color(0xFFFF7D16)))),
        ]),
        const SizedBox(height: 15),
        Row(children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                  color: const Color(0xFFE9FBF5),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFF8DE8C6))),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                const Icon(Icons.verified_outlined,
                    size: 15, color: Color(0xFF03966F)),
                const SizedBox(width: 4),
                Text(LocaleKeys.withdrawalReadyForDeposit,
                    style: styles.semiBold12
                        .copyWith(color: const Color(0xFF03966F)))
              ])),
          const Spacer(),
          const Icon(Icons.lock_outline_rounded,
              size: 14, color: Color(0xFF71809A)),
          const SizedBox(width: 4),
          Text(LocaleKeys.withdrawalSecureBalance,
              style: styles.regular11.copyWith(
                  color: dark ? Colors.white60 : const Color(0xFF71809A))),
        ]),
      ]),
    );
  }
}
