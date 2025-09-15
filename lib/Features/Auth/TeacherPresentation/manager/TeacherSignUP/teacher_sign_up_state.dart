// ignore_for_file: non_constant_identifier_names

part of 'teacher_sign_up_cubit.dart';

@immutable
sealed class TeacherSignUpState {}

final class TeacherSignUpInitial extends TeacherSignUpState {}

final class TeacherSignUpLoading extends TeacherSignUpState {}

final class TeacherSignUpSuccess extends TeacherSignUpState {}

final class TeacherSignUpFailure extends TeacherSignUpState {
  final String errmessage;

  TeacherSignUpFailure({required this.errmessage});
}

final class PickTeacherProfilePicSuccess extends TeacherSignUpState {
  PickTeacherProfilePicSuccess();
}
