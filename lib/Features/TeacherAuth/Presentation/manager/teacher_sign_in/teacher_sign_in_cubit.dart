import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Entities/Teacher_Entity.dart';
import 'package:sintir/Features/TeacherAuth/Domain/Repos/repos.dart';

part 'teacher_sign_in_state.dart';

class TeacherSignInCubit extends Cubit<TeacherSignInState> {
  TeacherSignInCubit({required this.teacherAuthRepos})
      : super(TeacherSignInInitial());
  TeacherAuthRepos teacherAuthRepos;
  Future<void> signInWithEmailAndPassword(
      {required String email, required String password}) async {
    emit(TeacherSignInLoading());
    var result = await teacherAuthRepos.signInWithEmailAndPassword(
        email: email, password: password);
    result.fold((failure) {
      emit(TeacherSignInFailure(errmessage: failure.message));
    }, (teacherEntity) {
      emit(TeacherSignInSuccess(teacherentity: teacherEntity));
    });
  }
}
