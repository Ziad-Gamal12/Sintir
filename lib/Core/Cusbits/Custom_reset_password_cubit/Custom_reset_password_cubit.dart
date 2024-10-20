import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/repos/authRepos/authrepo.dart';

part 'Custom_reset_password_state.dart';

class CustomResetPasswordCubit extends Cubit<CustomResetPasswordState> {
  CustomResetPasswordCubit({required this.authrepo})
      : super(CustomResetPasswordInitial());
  final Authrepo authrepo;
  Future<void> sendResetPasswordEmail({required String email}) async {
    emit(CustomResetPasswordLoading());
    try {
      await authrepo.resetPassword(email: email);
      emit(CustomResetPasswordSuccess());
    } on CustomException catch (e) {
      emit(CustomResetPasswordFailure(errmessage: e.message));
    } catch (e) {
      log("Exception from TeacherResetPasswordCubit.sendResetPasswordEmail in catch With Firebase Exception: ${e.toString()}");
      emit(CustomResetPasswordFailure(errmessage: e.toString()));
    }
  }
}
