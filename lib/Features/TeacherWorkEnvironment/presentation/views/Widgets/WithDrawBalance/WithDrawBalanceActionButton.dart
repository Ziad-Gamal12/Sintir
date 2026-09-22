import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/locale_keys.dart';
import 'package:uuid/uuid.dart';

class WithDrawBalanceActionButton extends StatelessWidget {
  const WithDrawBalanceActionButton(
      {super.key,
      required this.formKey,
      required this.amountController,
      required this.phoneController,
      required this.issuer,
      required this.isConditionAccepted,
      required this.walletEntity});
  final GlobalKey<FormState> formKey;
  final TextEditingController amountController;
  final TextEditingController phoneController;
  final String issuer;
  final bool isConditionAccepted;
  final TeacherWalletEntity walletEntity;
  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final enabled = isConditionAccepted &&
        walletEntity.status == BackendEndpoints.walletActive;
    final loading = context.select<WithDrawTeacherBalanceCubit, bool>(
        (c) => c.state is WithDrawBalanceLoading);
    return Custombutton(
        text: LocaleKeys.sendMoney,
        color: enabled ? colors.primary : Colors.blue.shade100,
        textColor: Colors.white,
        onPressed: enabled && !loading ? () => _submit(context) : () {},
        child: loading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                    strokeWidth: 2, color: Colors.white))
            : null);
  }

  void _submit(BuildContext context) {
    if (!formKey.currentState!.validate()) return;
    final amount = double.tryParse(amountController.text.trim());
    if (amount == null || amount < 100 || amount > 1000) {
      _error(context, LocaleKeys.invalidAmount);
      return;
    }
    if (!_matchesIssuer(phoneController.text.trim())) {
      _error(context, LocaleKeys.walletNumberMismatch);
      return;
    }
    context.read<WithDrawTeacherBalanceCubit>().requestWithdrawal(
        amount: amount,
        issuer: issuer,
        mobileNumber: phoneController.text.trim(),
        idempotencyKey: const Uuid().v4());
  }

  bool _matchesIssuer(String phone) {
    const prefixes = {'vodafone': '010', 'orange': '012', 'etisalat': '011'};
    return phone.length == 11 && phone.startsWith(prefixes[issuer] ?? '');
  }

  void _error(BuildContext context, String message) =>
      CustomSnackBar.show(context, message: message, type: SnackType.error);
}
