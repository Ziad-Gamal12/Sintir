part of 'teacher_reset_password_cubit.dart';

@immutable
sealed class TeacherResetPasswordState {}

final class TeacherResetPasswordInitial extends TeacherResetPasswordState {}

final class TeacherResetPasswordLoading extends TeacherResetPasswordState {}

final class TeacherResetPasswordSuccess extends TeacherResetPasswordState {}

final class TeacherResetPasswordFailure extends TeacherResetPasswordState {
  final String errmessage;
  TeacherResetPasswordFailure({required this.errmessage});
}
