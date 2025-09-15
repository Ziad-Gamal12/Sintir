// ignore_for_file: avoid_types_as_parameter_names, depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';

part 'teacher_sign_up_state.dart';

class TeacherSignUpCubit extends Cubit<TeacherSignUpState> {
  TeacherSignUpCubit(
    this.authRepo,
  ) : super(TeacherSignUpInitial());
  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword({
    required UserEntity userentity,
    required String password,
  }) async {
    emit(TeacherSignUpLoading());
    authRepo
        .signUpWithEmailAndPassword(userEntity: userentity, password: password)
        .then((value) {
      value.fold((failure) {
        emit(TeacherSignUpFailure(errmessage: failure.message));
      }, (value) {
        emit(TeacherSignUpSuccess());
      });
    });
  }
}
