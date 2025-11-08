import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/constant.dart';

class PayOutBalanceBodButton extends StatelessWidget {
  const PayOutBalanceBodButton({
    super.key,
    required this.formKey,
    required this.walletEntity,
    required this.amountController,
    required this.phoneController,
    required this.issuer,
  });

  final GlobalKey<FormState> formKey;
  final TeacherWalletEntity walletEntity;
  final TextEditingController amountController;
  final TextEditingController phoneController;
  final String issuer;

  @override
  Widget build(BuildContext context) {
    return Custombutton(
      text: "إرسال الأموال",
      color: KMainColor,
      textColor: Colors.white,
      onPressed: () {
        if (!formKey.currentState!.validate()) return;

        final amount = double.tryParse(amountController.text);
        if (amount == null) {
          ShowErrorSnackBar(context: context, message: "المبلغ غير صالح");
          return;
        }

        if (walletEntity.status != BackendEndpoints.walletActive) {
          ShowErrorSnackBar(context: context, message: "المحفظه غير مفعلة");
          return;
        }

        if (walletEntity.balance < amount) {
          ShowErrorSnackBar(
              context: context, message: "لا يوجد مبلغ كافي في المحفظه");
          return;
        }

        if (!validateIssuer(issuer: issuer, phone: phoneController.text)) {
          ShowErrorSnackBar(
              context: context, message: "رقم الهاتف غير متوافق مع المزود");
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
