import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

part 'teacher_reset_password_state.dart';

class TeacherResetPasswordCubit extends Cubit<TeacherResetPasswordState> {
  TeacherResetPasswordCubit({required this.teacherAuthRepos})
      : super(TeacherResetPasswordInitial());
  final TeacherAuthRepos teacherAuthRepos;
  Future<void> sendResetPasswordEmail({required String email}) async {
    emit(TeacherResetPasswordLoading());
    try {
      await teacherAuthRepos.resetPassword(email: email);
      emit(TeacherResetPasswordSuccess());
    } on CustomException catch (e) {
      emit(TeacherResetPasswordFailure(errmessage: e.message));
    } catch (e) {
      log("Exception from TeacherResetPasswordCubit.sendResetPasswordEmail in catch With Firebase Exception: ${e.toString()}");
      emit(TeacherResetPasswordFailure(errmessage: e.toString()));
    }
  }
}
