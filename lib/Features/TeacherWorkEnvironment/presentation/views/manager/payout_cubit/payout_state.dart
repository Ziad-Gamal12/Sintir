part of 'payout_cubit.dart';

@immutable
sealed class PayoutState {}

final class PayoutInitial extends PayoutState {}

final class PayoutLoading extends PayoutState {}

final class PayoutSuccess extends PayoutState {
  final String transactionId;
  PayoutSuccess({required this.transactionId});
}

final class PayoutFailure extends PayoutState {
  final String message;
  PayoutFailure({required this.message});
}
