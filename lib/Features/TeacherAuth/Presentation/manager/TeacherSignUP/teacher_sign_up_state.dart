// ignore_for_file: non_constant_identifier_names

part of 'teacher_sign_up_cubit.dart';

@immutable
sealed class TeacherSignUpState {}

final class TeacherSignUpInitial extends TeacherSignUpState {}

final class TeacherSignUpLoading extends TeacherSignUpState {}

final class TeacherSignUpSuccess extends TeacherSignUpState {
  final teacherEntity TeacherEntity;

  TeacherSignUpSuccess({required this.TeacherEntity});
}

final class TeacherSignUpFailure extends TeacherSignUpState {
  final String errmessage;

  TeacherSignUpFailure({required this.errmessage});
}

final class UploadProfilePictureLoading extends TeacherSignUpState {}

final class UploadProfilePictureSuccess extends TeacherSignUpState {
  final String url;

  UploadProfilePictureSuccess({required this.url});
}

final class UploadProfilePictureFailure extends TeacherSignUpState {
  final String errmessage;

  UploadProfilePictureFailure({required this.errmessage});
}
