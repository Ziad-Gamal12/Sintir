part of 'student_sign_in_cubit.dart';

@immutable
sealed class StudentSignInState {}

final class StudentSignInInitial extends StudentSignInState {}

final class StudentSignInLoading extends StudentSignInState {}

final class StudentSignInSuccess extends StudentSignInState {}

final class StudentSignInFailure extends StudentSignInState {
  final String errmessage;

  StudentSignInFailure({required this.errmessage});
}
