part of 'student_sign_up_cubit.dart';

@immutable
sealed class StudentSignUpState {}

final class StudentSignUpInitial extends StudentSignUpState {}

final class StudentSignUpLoading extends StudentSignUpState {}

final class StudentSignUpFailure extends StudentSignUpState {
  final String errmessage;
  StudentSignUpFailure({required this.errmessage});
}

final class StudentSignUpSuccess extends StudentSignUpState {}
