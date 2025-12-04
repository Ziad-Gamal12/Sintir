import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/locale_keys.dart';

class PayOutBalanceBodButton extends StatelessWidget {
  const PayOutBalanceBodButton({
    super.key,
    required this.formKey,
    required this.amountController,
    required this.phoneController,
    required this.issuer,
    required this.isConditionAccepted,
    required this.walletEntity,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController amountController;
  final TextEditingController phoneController;
  final String issuer;
  final bool isConditionAccepted;
  final TeacherWalletEntity walletEntity;
  @override
  Widget build(BuildContext context) {
    final ColorScheme colorScheme = Theme.of(context).colorScheme;

    final bool isWalletValid =
        walletEntity.status == BackendEndpoints.walletActive;
    final bool isButtonEnabled = isConditionAccepted && isWalletValid;

    void handleWithdrawal() {
      if (!formKey.currentState!.validate()) return;
      if (!isConditionAccepted) {
        CustomSnackBar.show(
          context,
          message: LocaleKeys.mustAcceptTerms,
          type: SnackType.error,
        );
        return;
      }

      // 3. Amount Validation
      final amount = double.tryParse(amountController.text);
      if (amount == null || amount <= 0) {
        CustomSnackBar.show(
          context,
          message: LocaleKeys.invalidAmount,
          type: SnackType.error,
        );
        return;
      }

      // 4. Wallet Status Check
      if (walletEntity.status != BackendEndpoints.walletActive) {
        CustomSnackBar.show(
          context,
          message: LocaleKeys.walletNotActive,
          type: SnackType.error,
        );
        return;
      }

      // 5. Balance Check
      if (walletEntity.balance < amount) {
        CustomSnackBar.show(
          context,
          message: LocaleKeys.insufficientBalance,
          type: SnackType.error,
        );
        return;
      }

      // 6. Issuer Validation
      if (!_validateIssuer(issuer: issuer, phone: phoneController.text)) {
        CustomSnackBar.show(
          context,
          message: LocaleKeys.walletNumberMismatch,
          type: SnackType.error,
        );
        return;
      }

      // Execute Payout
      context.read<PayoutCubit>().sendDisbursement(
            receiverMobile: phoneController.text,
            issuer: issuer,
            amount: amount,
          );
    }

    return Custombutton(
      text: LocaleKeys.sendMoney,
      // Use primary theme color
      color: colorScheme.primary,
      textColor: colorScheme.onPrimary,
      onPressed: isButtonEnabled ? handleWithdrawal : () {},
    );
  }

  bool _validateIssuer({required String issuer, required String phone}) {
    if (phone.length < 3) return false;

    const prefixes = {
      'vodafone': '010',
      'orange': '012',
      'we': '015',
      'etisalat': '011',
    };

    final expectedPrefix = prefixes[issuer];

    return expectedPrefix != null && phone.startsWith(expectedPrefix);
  }
}
