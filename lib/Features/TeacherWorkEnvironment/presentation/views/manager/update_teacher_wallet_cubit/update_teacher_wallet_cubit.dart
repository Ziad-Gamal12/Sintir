import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';

part 'update_teacher_wallet_state.dart';

class UpdateTeacherWalletCubit extends Cubit<UpdateTeacherWalletState> {
  UpdateTeacherWalletCubit({required this.teacherWalletRepo})
      : super(UpdateTeacherWalletInitial());
  final TeacherWalletRepo teacherWalletRepo;

  Future<void> updateTeacherWalletBalance(
      {required String teacherId, required double balance}) async {
    emit(UpdateTeacherWalletLoading());
    final result = await teacherWalletRepo.updateTeacherWalletBalance(
        teacherId: teacherId, balance: balance);
    result.fold((l) => emit(UpdateTeacherWalletFailure(errMessage: l.message)),
        (r) => emit(UpdateTeacherWalletSuccess()));
  }
}
