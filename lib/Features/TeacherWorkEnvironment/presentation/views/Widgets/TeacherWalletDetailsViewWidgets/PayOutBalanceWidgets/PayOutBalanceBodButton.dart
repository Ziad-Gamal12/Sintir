import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

class PayOutBalanceBodButton extends StatelessWidget {
  const PayOutBalanceBodButton({
    super.key,
    required this.formKey,
    required this.walletEntity,
    required this.amountController,
    required this.phoneController,
    required this.issuer,
    required this.isConditionAccepted,
  });

  final GlobalKey<FormState> formKey;
  final TeacherWalletEntity walletEntity;
  final TextEditingController amountController;
  final TextEditingController phoneController;
  final String issuer;
  final bool isConditionAccepted;
  @override
  Widget build(BuildContext context) {
    return Custombutton(
      text: LocaleKeys.sendMoney,
      color: KMainColor,
      textColor: Colors.white,
      onPressed: () {
        if (!formKey.currentState!.validate()) return;
        if (!isConditionAccepted) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.mustAcceptTerms,
            type: SnackType.error,
          );
          return;
        }
        final amount = double.tryParse(amountController.text);
        if (amount == null) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.invalidAmount,
            type: SnackType.error,
          );
          return;
        }

        if (walletEntity.status != BackendEndpoints.walletActive) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.walletNotActive,
            type: SnackType.error,
          );
          return;
        }

        if (walletEntity.balance < amount) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.insufficientBalance,
            type: SnackType.error,
          );
          return;
        }

        if (!validateIssuer(issuer: issuer, phone: phoneController.text)) {
          CustomSnackBar.show(
            context,
            message: LocaleKeys.walletNumberMismatch,
            type: SnackType.error,
          );
          return;
        }

        context.read<PayoutCubit>().sendDisbursement(
              receiverMobile: phoneController.text,
              issuer: issuer,
              amount: amount,
            );
      },
    );
  }

  bool validateIssuer({required String issuer, required String phone}) {
    const prefixes = {
      'vodafone': '010',
      'orange': '012',
      'we': '015',
      'etisalat': '011',
    };
    return prefixes[issuer]?.startsWith(phone.substring(0, 3)) ?? false;
  }
}
