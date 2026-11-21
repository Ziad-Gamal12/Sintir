part of 'update_user_phone_number_cubit.dart';

@immutable
sealed class UpdateUserPhoneNumberState {}

final class UpdateUserPhoneNumberInitial extends UpdateUserPhoneNumberState {}

final class UpdateUserPhoneNumberLoading extends UpdateUserPhoneNumberState {}

final class UpdateUserPhoneNumberSuccess extends UpdateUserPhoneNumberState {}

final class UpdateUserPhoneNumberFailure extends UpdateUserPhoneNumberState {
  final String errMessage;

  UpdateUserPhoneNumberFailure({required this.errMessage});
}
