import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/SharedWallet/withdraw/teacher_withdraw_unavailable_body.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/teacher_wallet_cubit/teacher_wallet_cubit.dart';

class TeacherWithdrawAccessGate extends StatelessWidget {
  const TeacherWithdrawAccessGate({
    super.key,
    required this.initialWallet,
    required this.child,
  });

  final TeacherWalletEntity initialWallet;
  final Widget child;

  TeacherWalletStatus _statusOf(TeacherWalletState state) =>
      (state.wallet ?? initialWallet).walletStatus;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherWalletCubit, TeacherWalletState>(
      buildWhen: (previous, current) =>
          _statusOf(previous) != _statusOf(current),
      builder: (context, state) {
        final status = _statusOf(state);
        return status.canWithdraw
            ? child
            : TeacherWithdrawUnavailableBody(status: status);
      },
    );
  }
}
