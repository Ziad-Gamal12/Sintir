import 'package:flutter/material.dart';
import 'package:sintir/Core/Enums/currency_enum.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/EarningsSummarySection/CustomEarningsSummaryCard.dart';
import 'package:sintir/locale_keys.dart';

class EarningsSummaryCards extends StatelessWidget {
  const EarningsSummaryCards({super.key, required this.teacherWalletEntity});
  final TeacherWalletEntity teacherWalletEntity;

  @override
  Widget build(BuildContext context) {
    final currency = currencyFromString(teacherWalletEntity.currency).symbol;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Expanded(
          child: CustomEarningsSummaryCard(
            value: teacherWalletEntity.totalEarned.toStringAsFixed(2),
            title: LocaleKeys.totalEarningsLabel,
            currency: currency,
          ),
        ),
        Expanded(
          child: CustomEarningsSummaryCard(
            value: teacherWalletEntity.payoutPending.toStringAsFixed(2),
            title: LocaleKeys.pendingWithdrawalLabel,
            currency: currency,
          ),
        ),
        Expanded(
          child: CustomEarningsSummaryCard(
            value: teacherWalletEntity.balance.toStringAsFixed(2),
            title: LocaleKeys.availableForWithdrawalLabel,
            valueColor: Colors.green,
            currency: currency,
          ),
        ),
      ],
    );
  }
}
