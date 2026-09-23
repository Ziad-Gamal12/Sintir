import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

import 'WithdrawalSurfaceCard.dart';

class WithdrawalAmountCard extends StatefulWidget {
  const WithdrawalAmountCard(
      {super.key,
      required this.controller,
      required this.onWithdrawAll,
      required this.availableAmount});
  final TextEditingController controller;
  final VoidCallback onWithdrawAll;
  final double availableAmount;
  @override
  State<WithdrawalAmountCard> createState() => _WithdrawalAmountCardState();
}

class _WithdrawalAmountCardState extends State<WithdrawalAmountCard> {
  bool isValid = false;
  late final VoidCallback _listener;
  @override
  void initState() {
    super.initState();
    isValid = _valid;
    _listener = () {
      if (mounted && isValid != _valid) setState(() => isValid = _valid);
    };
    widget.controller.addListener(_listener);
  }

  bool get _valid {
    final amount = double.tryParse(widget.controller.text.trim());
    return amount != null &&
        amount >= 100 &&
        amount <= 1000 &&
        amount <= widget.availableAmount &&
        (amount * 100).roundToDouble() == amount * 100;
  }

  @override
  void dispose() {
    widget.controller.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final styles = AppTextStyles(context);
    final statusColor =
        isValid ? const Color(0xFF009E73) : const Color(0xFFE34D59);
    return WithdrawalSurfaceCard(
        child:
            Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(LocaleKeys.withdrawalAmount, style: styles.bold16),
        TextButton(
            onPressed: widget.onWithdrawAll,
            child: Text(LocaleKeys.withdrawalAllBalance))
      ]),
      TextField(
          controller: widget.controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textDirection: TextDirection.ltr,
          textAlign: TextAlign.right,
          style: styles.bold19,
          decoration: InputDecoration(
              prefixText: '${LocaleKeys.currencyEGP}  ',
              suffixIcon: Icon(
                  isValid
                      ? Icons.check_circle_outline_rounded
                      : Icons.error_outline_rounded,
                  color: statusColor))),
      const SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(LocaleKeys.withdrawalMinimum,
            style: styles.regular12.copyWith(color: const Color(0xFF71809A))),
        Text(
            isValid
                ? LocaleKeys.withdrawalValidAmount
                : LocaleKeys.withdrawalMinimum,
            style: styles.semiBold12.copyWith(color: statusColor))
      ])
    ]));
  }
}
