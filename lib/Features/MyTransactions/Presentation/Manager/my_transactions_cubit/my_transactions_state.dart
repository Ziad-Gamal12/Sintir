part of 'my_transactions_cubit.dart';

@immutable
sealed class MyTransactionsState {}

final class MyTransactionsInitial extends MyTransactionsState {}

final class GetMyTransactionsLoading extends MyTransactionsState {
  final bool isPaginate;
  GetMyTransactionsLoading({required this.isPaginate});
}

final class GetMyTransactionsSuccess extends MyTransactionsState {
  final GetMyTransactionsResponseEntity getMyTransactionsResponseEntity;
  GetMyTransactionsSuccess({required this.getMyTransactionsResponseEntity});
}

final class GetMyTransactionsFailure extends MyTransactionsState {
  final String errmessage;
  GetMyTransactionsFailure({required this.errmessage});
}
