part of 'TransactionsCubit.dart';

@immutable
sealed class TransactionsState {}

final class UpdateTeacherWalletInitial extends TransactionsState {}

final class UpdateTeacherWalletLoading extends TransactionsState {}

final class UpdateTeacherWalletSuccess extends TransactionsState {}

final class UpdateTeacherWalletFailure extends TransactionsState {
  final String errMessage;
  UpdateTeacherWalletFailure({required this.errMessage});
}

final class StoreTransactionSuccess extends TransactionsState {}

final class StoreTransactionFailure extends TransactionsState {
  final String errMessage;
  StoreTransactionFailure({required this.errMessage});
}

final class StoreTransactionLoading extends TransactionsState {}

final class ReconcileTransactionLoading extends TransactionsState {
  final String transactionId;
  ReconcileTransactionLoading({required this.transactionId});
}

final class ReconcileTransactionSuccess extends TransactionsState {
  final String transactionId;
  ReconcileTransactionSuccess({required this.transactionId});
}

final class ReconcileTransactionFailure extends TransactionsState {
  final String transactionId;
  final String errMessage;
  ReconcileTransactionFailure(
      {required this.transactionId, required this.errMessage});
}
