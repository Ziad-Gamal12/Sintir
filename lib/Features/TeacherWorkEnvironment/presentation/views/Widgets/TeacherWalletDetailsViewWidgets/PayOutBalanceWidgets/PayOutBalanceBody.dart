import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodyConditionsRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodyTextFields.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/SelecteIssuerDropDownButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/update_teacher_wallet_cubit/update_teacher_wallet_cubit.dart';
import 'package:sintir/constant.dart';
import 'package:sintir/locale_keys.dart';

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

  String issuer = "vodafone";
  String transactionId = "";
  bool isLoading = false;
  bool isAgree = false;

  @override
  void dispose() {
    phoneController.dispose();
    amountController.dispose();
    super.dispose();
  }

  // --------------------- Bloc Listeners ---------------------

  void _handlePayoutState(BuildContext context, PayoutState state) {
    if (state is PayoutLoading) {
      _setLoading(true);
    } else if (state is PayoutSuccess) {
      transactionId = state.transactionId;
      _updateWalletBalance(context);
    } else if (state is PayoutFailure) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message: state.message,
        type: SnackType.error,
      );
    }
  }

  void _handleUpdateWalletState(
      BuildContext context, UpdateTeacherWalletState state) {
    if (state is UpdateTeacherWalletLoading) {
      _setLoading(true);
    } else if (state is UpdateTeacherWalletSuccess) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message: LocaleKeys.operationSuccessful,
        type: SnackType.success,
      );
    } else if (state is UpdateTeacherWalletFailure) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message: state.errMessage,
        type: SnackType.error,
      );
    }
  }

  void _updateWalletBalance(BuildContext context) {
    context.read<UpdateTeacherWalletCubit>().updateTeacherWalletBalance(
          teacherId: widget.walletEntity.teacherId,
          balance:
              widget.walletEntity.balance - double.parse(amountController.text),
        );
  }

  void _setLoading(bool value) => setState(() => isLoading = value);

  // --------------------- UI ---------------------

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PayoutCubit, PayoutState>(listener: _handlePayoutState),
        BlocListener<UpdateTeacherWalletCubit, UpdateTeacherWalletState>(
          listener: _handleUpdateWalletState,
        ),
      ],
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: KHorizontalPadding,
          vertical: KVerticalPadding,
        ),
        child: Form(
          key: formKey,
          child: Column(
            children: [
              const Divider(
                thickness: 1,
                indent: 80,
                endIndent: 80,
                color: Colors.black,
              ),
              const SizedBox(height: 20),

              /// Text Fields
              PayOutBalanceBodyTextFields(
                phoneController: phoneController,
                amountController: amountController,
              ),

              const SizedBox(height: 20),

              /// Issuer Dropdown
              SelecteIssuerDropDownButton(
                onSelected: (value) => setState(() => issuer = value ?? ""),
              ),

              const SizedBox(height: 20),
              PayOutBalanceBodyConditionsRow(
                onChanged: (value) {
                  setState(() => isAgree = value);
                },
              ),
              const SizedBox(height: 80),

              /// Submit Button + Loading
              Custom_Loading_Widget(
                isLoading: isLoading,
                child: PayOutBalanceBodButton(
                  formKey: formKey,
                  isConditionAccepted: isAgree,
                  issuer: issuer,
                  walletEntity: widget.walletEntity,
                  amountController: amountController,
                  phoneController: phoneController,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
