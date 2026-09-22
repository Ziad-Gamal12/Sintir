part of 'WithDrawTeacherBalanceCubit.dart';

@immutable
sealed class WithDrawTeacherBalanceState {
  const WithDrawTeacherBalanceState();
}

final class WithDrawBalanceInitial extends WithDrawTeacherBalanceState {
  const WithDrawBalanceInitial();
}

final class WithDrawBalanceLoading extends WithDrawTeacherBalanceState {
  const WithDrawBalanceLoading();
}

final class WithDrawBalanceSuccess extends WithDrawTeacherBalanceState {
  const WithDrawBalanceSuccess({required this.result});
  final TeacherWithdrawalResultEntity result;
}

final class WithDrawBalanceFailure extends WithDrawTeacherBalanceState {
  const WithDrawBalanceFailure({required this.errMessage});
  final String errMessage;
}

final class ReconcileTransactionLoading extends WithDrawTeacherBalanceState {
  const ReconcileTransactionLoading({required this.transactionId});
  final String transactionId;
}

final class ReconcileTransactionSuccess extends WithDrawTeacherBalanceState {
  const ReconcileTransactionSuccess({required this.result});
  final TeacherWithdrawalResultEntity result;
}

final class ReconcileTransactionFailure extends WithDrawTeacherBalanceState {
  const ReconcileTransactionFailure({
    required this.transactionId,
    required this.errMessage,
  });
  final String transactionId;
  final String errMessage;
}
