part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

final class PaymentSuccess extends PaymentState {
  final String token;
  PaymentSuccess({required this.token});
}

final class PaymentError extends PaymentState {
  final String message;
  PaymentError({required this.message});
}

final class PaymentLoading extends PaymentState {}
