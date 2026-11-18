import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherLiveWalletRepo.dart';

part 'teacher_wallet_state.dart';

class TeacherWalletCubit extends Cubit<TeacherWalletState> {
  TeacherWalletCubit({
    required TeacherLiveWalletRepo walletRepo,
    required String teacherId,
  }) : _walletRepo = walletRepo,
       _teacherId = teacherId,
       super(const TeacherWalletLoading());

  final TeacherLiveWalletRepo _walletRepo;
  final String _teacherId;
  StreamSubscription<Either<Failure, TeacherWalletEntity>>? _subscription;

  void watchWallet() {
    unawaited(_subscription?.cancel());

    if (state is TeacherWalletFailure && state.wallet == null) {
      emit(const TeacherWalletLoading());
    }

    _subscription = _walletRepo
        .watchWallet(teacherId: _teacherId)
        .listen(
          (result) => result.fold(
            (failure) => emit(
              TeacherWalletFailure(
                message: failure.message,
                wallet: state.wallet,
              ),
            ),
            (wallet) => emit(TeacherWalletLoaded(wallet)),
          ),
        );
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    _subscription = null;
    return super.close();
  }
}
