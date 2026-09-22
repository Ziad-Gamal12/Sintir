import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletTransactionListener {
  final String transactionID;

  TeacherWalletTransactionListener({required this.transactionID});

  void withDrawtTeacherBalanceListener(
      {required BuildContext context,
      required WithDrawTeacherBalanceState state}) {
    if (state is ReconcileTransactionFailure &&
        state.transactionId == transactionID) {
      CustomSnackBar.show(
        context,
        message: state.errMessage,
        type: SnackType.error,
      );
    } else if (state is ReconcileTransactionSuccess &&
        state.result.withdrawalId == transactionID) {
      CustomSnackBar.show(
        context,
        message: LocaleKeys.transactionStatusUpdatedSuccess,
        type: SnackType.success,
      );
    }
  }
}
