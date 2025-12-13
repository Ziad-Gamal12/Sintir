part of 'WithDrawTeacherBalanceCubit.dart';

@immutable
sealed class WithDrawTeacherBalanceState {}

final class UpdateTeacherWalletInitial extends WithDrawTeacherBalanceState {}

final class UpdateTeacherWalletLoading extends WithDrawTeacherBalanceState {}

final class UpdateTeacherWalletSuccess extends WithDrawTeacherBalanceState {}

final class UpdateTeacherWalletFailure extends WithDrawTeacherBalanceState {
  final String errMessage;
  UpdateTeacherWalletFailure({required this.errMessage});
}

final class StoreTransactionSuccess extends WithDrawTeacherBalanceState {}

final class StoreTransactionFailure extends WithDrawTeacherBalanceState {
  final String errMessage;
  StoreTransactionFailure({required this.errMessage});
}

final class StoreTransactionLoading extends WithDrawTeacherBalanceState {}

final class ReconcileTransactionLoading extends WithDrawTeacherBalanceState {
  final String transactionId;
  ReconcileTransactionLoading({required this.transactionId});
}

final class ReconcileTransactionSuccess extends WithDrawTeacherBalanceState {
  final String transactionId;
  ReconcileTransactionSuccess({required this.transactionId});
}

final class ReconcileTransactionFailure extends WithDrawTeacherBalanceState {
  final String transactionId;
  final String errMessage;
  ReconcileTransactionFailure(
      {required this.transactionId, required this.errMessage});
}
