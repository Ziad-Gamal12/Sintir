// ignore_for_file: depend_on_referenced_packages, avoid_types_as_parameter_names

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';

part 'teacher_sign_in_state.dart';

class TeacherSignInCubit extends Cubit<TeacherSignInState> {
  TeacherSignInCubit({required this.authrepo}) : super(TeacherSignInInitial());
  final AuthRepo authrepo;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(TeacherSignInLoading());
    final result = await authrepo.signInWithEmailAndPassword(
        email: email, password: password);
    result.fold((failure) {
      emit(TeacherSignInFailure(errmessage: failure.message));
    }, (teacherEntity) {
      emit(TeacherSignInSuccess());
    });
  }
}
