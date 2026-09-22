import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

import 'WithdrawalSurfaceCard.dart';

class WithdrawalSummaryCard extends StatelessWidget {
  const WithdrawalSummaryCard({super.key, required this.amount});
  final String amount;
  @override
  Widget build(BuildContext context) {
    final s = AppTextStyles(context);
    return WithdrawalSurfaceCard(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Text(LocaleKeys.withdrawalSummary, style: s.bold16),
      const SizedBox(height: 10),
      _SummaryRow(
          LocaleKeys.withdrawalRequested, '$amount ${LocaleKeys.currencyEGP}'),
      _SummaryRow(LocaleKeys.withdrawalFees, LocaleKeys.withdrawalFree,
          green: true),
      const Divider(),
      _SummaryRow(LocaleKeys.withdrawalNet, '$amount ${LocaleKeys.currencyEGP}',
          orange: true, bold: true)
    ]));
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow(this.label, this.value,
      {this.green = false, this.orange = false, this.bold = false});
  final String label, value;
  final bool green, orange, bold;
  @override
  Widget build(BuildContext context) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label,
            style: bold
                ? AppTextStyles(context).bold16
                : AppTextStyles(context).regular13),
        Text(value,
            textDirection: TextDirection.ltr,
            style: (bold
                    ? AppTextStyles(context).bold16
                    : AppTextStyles(context).semiBold13)
                .copyWith(
                    color: green
                        ? const Color(0xFF009E73)
                        : orange
                            ? const Color(0xFFFF7D16)
                            : null))
      ]));
}
