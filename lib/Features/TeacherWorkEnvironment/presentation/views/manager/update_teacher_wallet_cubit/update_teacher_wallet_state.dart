part of 'update_teacher_wallet_cubit.dart';

@immutable
sealed class UpdateTeacherWalletState {}

final class UpdateTeacherWalletInitial extends UpdateTeacherWalletState {}

final class UpdateTeacherWalletLoading extends UpdateTeacherWalletState {}

final class UpdateTeacherWalletSuccess extends UpdateTeacherWalletState {}

final class UpdateTeacherWalletFailure extends UpdateTeacherWalletState {
  final String errMessage;
  UpdateTeacherWalletFailure({required this.errMessage});
}
