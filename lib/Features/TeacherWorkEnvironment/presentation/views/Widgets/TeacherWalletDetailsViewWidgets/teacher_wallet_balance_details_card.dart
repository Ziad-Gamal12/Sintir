import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletBalanceDetailsCard extends StatelessWidget {
  const TeacherWalletBalanceDetailsCard({
    super.key,
    required this.wallet,
  });
  final TeacherWalletEntity wallet;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(
          color: theme.dividerColor,
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.walletBalance,
            style: AppTextStyles(context)
                .regular16
                .copyWith(color: theme.textTheme.bodyMedium?.color),
          ),
          const SizedBox(height: 10),
          Text(
            "${wallet.balance.toStringAsFixed(2) ?? 0}  ${LocaleKeys.priceEgp}",
            style: AppTextStyles(context).bold32.copyWith(color: KMainColor),
          ),
        ],
      ),
    );
  }
}
