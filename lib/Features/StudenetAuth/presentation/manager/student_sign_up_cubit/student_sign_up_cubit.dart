// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/StudenetAuth/domain/entities/studentEntity.dart';
import 'package:sintir/Features/StudenetAuth/domain/repos/studentAuth_repo.dart';

part 'student_sign_up_state.dart';

class StudentSignUpCubit extends Cubit<StudentSignUpState> {
  StudentSignUpCubit(this.studentauthRepo) : super(StudentSignUpInitial());
  final StudentauthRepo studentauthRepo;

  Future<void> createUserWithEmailAndPassword(
      {required Studententity studentEntity, required String password}) async {
    emit(StudentSignUpLoading());
    var result = await studentauthRepo.createUserWithEmailAndPassword(
        password: password, studentEntity: studentEntity);
    result.fold((failure) {
      emit(StudentSignUpFailure(errmessage: failure.message));
    }, (studententity) {
      emit(StudentSignUpSuccess());
    });
  }
}
