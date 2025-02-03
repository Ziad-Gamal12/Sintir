part of 'teacher_sign_in_cubit.dart';

@immutable
sealed class TeacherSignInState {}

final class TeacherSignInInitial extends TeacherSignInState {}

final class TeacherSignInLoading extends TeacherSignInState {}

final class TeacherSignInSuccess extends TeacherSignInState {}

final class TeacherSignInFailure extends TeacherSignInState {
  final String errmessage;
  TeacherSignInFailure({required this.errmessage});
}
