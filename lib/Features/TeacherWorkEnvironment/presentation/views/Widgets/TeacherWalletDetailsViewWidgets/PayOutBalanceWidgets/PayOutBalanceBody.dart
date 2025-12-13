import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Core/widgets/Custom_Loading_Widget.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodyConditionsRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/PayOutBalanceBodyTextFields.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/TeacherWalletDetailsViewWidgets/PayOutBalanceWidgets/SelecteIssuerDropDownButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/payout_cubit/payout_cubit.dart';
import 'package:sintir/constant.dart';

class PayOutBalanceBody extends StatefulWidget {
  const PayOutBalanceBody({
    super.key,
    required this.currentWallet,
  });

  final TeacherWalletEntity currentWallet;

  @override
  State<PayOutBalanceBody> createState() => _PayOutBalanceBodyState();
}

class _PayOutBalanceBodyState extends State<PayOutBalanceBody> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // Transaction entity for the current attempt
  late TransactionEntity _currentTransaction;
  String issuer = "";
  bool isLoading = false;
  bool isAgree = false;

  @override
  void initState() {
    super.initState();
    _currentTransaction = TransactionEntity(
        amount: 0.0,
        issuer: issuer,
        method: BackendEndpoints.payOutMethod,
        isReconciled: false,
        mobileNumber: "",
        transactionId: "",
        currency: "EGP",
        createdAt: DateTime.now(),
        status: "PENDING");
  }

  @override
  void dispose() {
    phoneController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _handlePayoutState(BuildContext context, PayoutState state) {
    if (state is PayoutLoading) {
      _setLoading(true);
      CustomSnackBar.show(context,
          message: 'Initiating withdrawal...', type: SnackType.info);
    } else if (state is PayoutSuccess) {
      final double? amount = double.tryParse(amountController.text);

      _currentTransaction = _currentTransaction.copyWith(
        transactionId: state.transactionId,
        mobileNumber: phoneController.text,
        issuer: issuer,
        amount: amount,
        status: "PENDING",
      );

      _updateWalletBalance(context, amount ?? 0.0);
    } else if (state is PayoutFailure) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message: 'Withdrawal Rejected: ${state.message}',
        type: SnackType.error,
      );
    }
  }

  void _handleUpdateWalletState(
      BuildContext context, WithDrawTeacherBalanceState state) {
    if (state is UpdateTeacherWalletLoading) {
      _setLoading(true);
    } else if (state is UpdateTeacherWalletSuccess) {
      context.read<WithDrawTeacherBalanceCubit>().storeTransaction(
            transaction: _currentTransaction,
            userId: widget.currentWallet.teacherId,
          );
    } else if (state is UpdateTeacherWalletFailure) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message:
            'Error! Balance deduction failed: ${state.errMessage}. Please contact support.',
        type: SnackType.error,
      );
    } else if (state is StoreTransactionSuccess) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message: 'Withdrawal is now PENDING. Check your transactions list.',
        type: SnackType.success,
      );
    } else if (state is StoreTransactionFailure) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message:
            'Error! Balance deducted but record failed to save: ${state.errMessage}. Contact support.',
        type: SnackType.error,
      );
    } else if (state is StoreTransactionLoading) {
      _setLoading(true);
    } else if (state is StoreTransactionFailure) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message:
            'Error! Balance deducted but record failed to save: ${state.errMessage}. Contact support.',
        type: SnackType.error,
      );
    } else if (state is StoreTransactionSuccess) {
      _setLoading(false);
      CustomSnackBar.show(
        context,
        message: 'Withdrawal is now PENDING. Check your transactions list.',
        type: SnackType.success,
      );
    }
  }

  void _updateWalletBalance(BuildContext context, double amountToSubtract) {
    final TeacherWalletEntity walletEntity = widget.currentWallet;

    if (amountToSubtract <= 0) {
      CustomSnackBar.show(context,
          message:
              'Internal Error: Invalid amount detected after payout success.',
          type: SnackType.error);
      _setLoading(false);
      return;
    }

    context.read<WithDrawTeacherBalanceCubit>().updateTeacherWalletBalance(
          teacherId: walletEntity.teacherId,
          balance: walletEntity.balance - amountToSubtract,
        );
  }

  void _setLoading(bool value) => setState(() => isLoading = value);

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<PayoutCubit, PayoutState>(listener: _handlePayoutState),
        BlocListener<WithDrawTeacherBalanceCubit, WithDrawTeacherBalanceState>(
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
                color: Colors.grey,
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

              Custom_Loading_Widget(
                isLoading: isLoading,
                child: PayOutBalanceBodButton(
                  formKey: formKey,
                  isConditionAccepted: isAgree,
                  issuer: issuer,
                  amountController: amountController,
                  phoneController: phoneController,
                  walletEntity: widget.currentWallet,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
