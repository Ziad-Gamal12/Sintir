// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';

part 'student_sign_in_state.dart';

class StudentSignInCubit extends Cubit<StudentSignInState> {
  StudentSignInCubit(this.authrepo) : super(StudentSignInInitial());
  final AuthRepo authrepo;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(StudentSignInLoading());
    var result = await authrepo.signInWithEmailAndPassword(
        email: email, password: password);
    result.fold((failure) {
      emit(StudentSignInFailure(errmessage: failure.message));
    }, (studentEntity) {
      emit(StudentSignInSuccess());
    });
  }

  Future<void> signInWithGoogle() async {
    emit(StudentSignInLoading());
    var result = await authrepo.signInWithGoogle();
    result.fold((failure) {
      emit(StudentSignInFailure(errmessage: failure.message));
    }, (studentEntity) {
      emit(StudentSignInSuccess());
    });
  }

  Future<void> signInWithFacebook() async {
    emit(StudentSignInLoading());
    var result = await authrepo.signInWithFacebook();
    result.fold((failure) {
      emit(StudentSignInFailure(errmessage: failure.message));
    }, (studentEntity) {
      emit(StudentSignInSuccess());
    });
  }
}
