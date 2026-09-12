import 'package:flutter/material.dart';
import 'package:sintir/Core/Enums/currency_enum.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/EarningsSummarySection/CustomEarningsSummaryCard.dart';

class EarningsSummaryCards extends StatefulWidget {
  const EarningsSummaryCards({super.key, required this.teacherWalletEntity});
  final TeacherWalletEntity teacherWalletEntity;

  @override
  State<EarningsSummaryCards> createState() => _EarningsSummaryCardsState();
}

class _EarningsSummaryCardsState extends State<EarningsSummaryCards> {
  @override
  Widget build(BuildContext context) {
    final currency =
        currencyFromString(widget.teacherWalletEntity.currency).symbol;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Expanded(
          child: CustomEarningsSummaryCard(
            value: widget.teacherWalletEntity.totalEarned.toStringAsFixed(2),
            title: 'إجمالي الأرباح',
            currency: currency,
          ),
        ),
        Expanded(
          child: CustomEarningsSummaryCard(
            value: widget.teacherWalletEntity.payoutPending.toStringAsFixed(2),
            title: 'قيد السحب',
            currency: currency,
          ),
        ),
        Expanded(
          child: CustomEarningsSummaryCard(
            value: widget.teacherWalletEntity.balance.toStringAsFixed(2),
            title: 'المتاح للسحب',
            valueColor: Colors.green,
            currency: currency,
          ),
        ),
      ],
    );
  }
}
