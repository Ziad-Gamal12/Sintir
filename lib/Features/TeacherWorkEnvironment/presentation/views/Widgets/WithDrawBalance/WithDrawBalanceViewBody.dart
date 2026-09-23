import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/WithdrawalMethodEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/WithdrawalMethods.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/WithDrawBalance/WithDrawBalanceActionButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/WithDrawBalance/WithDrawBalanceConditionsRow.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';

import 'AvailableBalanceSectionCard.dart';
import 'WithdrawalAccountCard.dart';
import 'WithdrawalAmountCard.dart';
import 'WithdrawalMethodsCard.dart';
import 'WithdrawalSummaryCard.dart';

class WithDrawBalanceViewBody extends StatefulWidget {
  const WithDrawBalanceViewBody({super.key});
  @override
  State<WithDrawBalanceViewBody> createState() =>
      _WithDrawBalanceViewBodyState();
}

class _WithDrawBalanceViewBodyState extends State<WithDrawBalanceViewBody> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _amountController;
  late final TextEditingController _recipientWalletNumber;
  late WithdrawalMethodEntity _selectedMethod;
  bool isTremsAccepted = false;
  @override
  void initState() {
    super.initState();
    final wallet = context.read<TeacherWalletEntity>();
    _amountController = TextEditingController(
        text: math.min(wallet.balance, 1000).toStringAsFixed(2));
    _recipientWalletNumber = TextEditingController();
    _selectedMethod = WithdrawalMethods.all.first;
  }

  @override
  void dispose() {
    _amountController.dispose();
    _recipientWalletNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final wallet = context.read<TeacherWalletEntity>();
    final dark = Theme.of(context).brightness == Brightness.dark;
    return BlocListener<WithDrawTeacherBalanceCubit,
        WithDrawTeacherBalanceState>(
      listener: (context, state) {
        if (state is WithDrawBalanceSuccess) {
          CustomSnackBar.show(
            context,
            message: state.result.message ??
                'Withdrawal request received. Check its status in transactions.',
            type: SnackType.success,
          );
        } else if (state is WithDrawBalanceFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        }
      },
      child: Directionality(
          textDirection: Directionality.of(context),
          child: ColoredBox(
              color: dark ? const Color(0xFF121212) : const Color(0xFFF7F9FC),
              child: Form(
                  key: _formKey,
                  child: ListView(padding: const EdgeInsets.all(16), children: [
                    AvailableBalanceSectionCard(
                        availableBalance: wallet.balance),
                    const SizedBox(height: 16),
                    WithdrawalAmountCard(
                        controller: _amountController,
                        availableAmount: wallet.balance,
                        onWithdrawAll: () => setState(() => _amountController
                                .text =
                            math.min(wallet.balance, 1000).toStringAsFixed(2))),
                    const SizedBox(height: 16),
                    WithdrawalMethodsCard(
                        methods: WithdrawalMethods.all,
                        selectedId: _selectedMethod.id,
                        onSelected: (value) =>
                            setState(() => _selectedMethod = value)),
                    const SizedBox(height: 16),
                    WithdrawalAccountCard(controller: _recipientWalletNumber),
                    const SizedBox(height: 16),
                    WithdrawalSummaryCard(amount: _amountController.text),
                    const SizedBox(height: 22),
                    WithDrawBalanceConditionsRow(
                      onChanged: (value) {
                        setState(() => isTremsAccepted = value);
                      },
                    ),
                    const SizedBox(height: 12),
                    WithDrawBalanceActionButton(
                        formKey: _formKey,
                        amountController: _amountController,
                        phoneController: _recipientWalletNumber,
                        issuer: _selectedMethod.id,
                        isConditionAccepted: isTremsAccepted,
                        walletEntity: wallet)
                  ])))),
    );
  }
}
