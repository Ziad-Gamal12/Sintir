// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/Auth/Domain/Entities/UserEntity.dart';
import 'package:sintir/Features/Auth/Domain/Repos/AuthRepo.dart';

part 'student_sign_up_state.dart';

class StudentSignUpCubit extends Cubit<StudentSignUpState> {
  StudentSignUpCubit(this.aauthRepo) : super(StudentSignUpInitial());
  final AuthRepo aauthRepo;

  Future<void> createUserWithEmailAndPassword(
      {required UserEntity userEntity, required String password}) async {
    emit(StudentSignUpLoading());
    var result = await aauthRepo.signUpWithEmailAndPassword(
        password: password, userEntity: userEntity);
    result.fold((failure) {
      emit(StudentSignUpFailure(errmessage: failure.message));
    }, (studententity) {
      emit(StudentSignUpSuccess());
    });
  }
}
