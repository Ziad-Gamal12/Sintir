// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';

part 'student_sign_in_state.dart';

class StudentSignInCubit extends Cubit<StudentSignInState> {
  StudentSignInCubit(this.studentauthRepo) : super(StudentSignInInitial());
  final StudentauthRepo studentauthRepo;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(StudentSignInLoading());
    var result = await studentauthRepo.sginInWithEmailAndPasswoed(
        email: email, password: password);
    result.fold((failure) {
      emit(StudentSignInFailure(errmessage: failure.message));
    }, (studentEntity) {
      emit(StudentSignInSuccess(studententity: studentEntity));
    });
  }

  Future<void> signInWithGoogle() async {
    emit(StudentSignInLoading());
    var result = await studentauthRepo.signinWithGoogle();
    result.fold((failure) {
      emit(StudentSignInFailure(errmessage: failure.message));
    }, (studentEntity) {
      emit(StudentSignInSuccess(studententity: studentEntity));
    });
  }

  Future<void> signInWithFacebook() async {
    emit(StudentSignInLoading());
    var result = await studentauthRepo.signinWithFaceBook();
    result.fold((failure) {
      emit(StudentSignInFailure(errmessage: failure.message));
    }, (studentEntity) {
      emit(StudentSignInSuccess(studententity: studentEntity));
    });
  }

  Future<void> signInWithApple() async {
    emit(StudentSignInLoading());
    var result = await studentauthRepo.signinWithApple();
    result.fold((failure) {
      emit(StudentSignInFailure(errmessage: failure.message));
    }, (studentEntity) {
      emit(StudentSignInSuccess(studententity: studentEntity));
    });
  }
}
