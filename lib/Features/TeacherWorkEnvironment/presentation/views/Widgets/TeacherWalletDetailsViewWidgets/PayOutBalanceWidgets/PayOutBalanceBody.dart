import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodyTextFields.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/SelecteIssuerDropDownButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/constant.dart';

class PayOutBalanceBody extends StatefulWidget {
  const PayOutBalanceBody({super.key, required this.walletEntity});
  final TeacherWalletEntity walletEntity;

  @override
  State<PayOutBalanceBody> createState() => _PayOutBalanceBodyState();
}

class _PayOutBalanceBodyState extends State<PayOutBalanceBody> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String transactionId = "";
  String issuer = "vodafone";

  @override
  void dispose() {
    phoneController.dispose();
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<PayoutCubit, PayoutState>(
      listener: (context, state) {
        if (state is PayoutSuccess) {
          transactionId = state.transactionId;
          showSuccessSnackBar(context: context, message: state.transactionId);
        } else if (state is PayoutFailure) {
          ShowErrorSnackBar(context: context, message: state.message);
        }
      },
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: KHorizontalPadding,
              vertical: KVerticalPadding,
            ),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  PayOutBalanceBodyTextFields(
                      phoneController: phoneController,
                      amountController: amountController),
                  const SizedBox(
                    height: 20,
                  ),
                  SelecteIssuerDropDownButton(
                    onSelected: (value) {
                      issuer = value ?? "";
                      setState(() {});
                    },
                  ),
                  const Spacer(),
                  Custom_Loading_Widget(
                    isLoading: state is PayoutLoading,
                    child: PayOutBalanceBodButton(
                        formKey: formKey,
                        issuer: issuer,
                        walletEntity: widget.walletEntity,
                        amountController: amountController,
                        phoneController: phoneController),
                  ),
                ],
              ),
            ));
      },
    );
  }
}
