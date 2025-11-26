import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletBalanceDetailsCard extends StatelessWidget {
  final TeacherWalletEntity? wallet;

  const TeacherWalletBalanceDetailsCard({super.key, required this.wallet});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      alignment: Alignment.center,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.lightBlue.shade100,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
        border: Border.all(color: Colors.grey.shade100, width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            LocaleKeys.walletBalance,
            style:
                AppTextStyles(context).regular16.copyWith(color: Colors.black),
          ),
          const SizedBox(height: 10),
          Text(
            "${wallet?.balance.toStringAsFixed(2) ?? 0} جنيه",
            style: AppTextStyles(context).bold32.copyWith(color: KMainColor),
          ),
        ],
      ),
    );
  }
}
