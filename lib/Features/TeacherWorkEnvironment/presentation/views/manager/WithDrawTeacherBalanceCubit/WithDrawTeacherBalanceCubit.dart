import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWithdrawalResultEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';

part 'WithDrawTeacherBalanceState.dart';

class WithDrawTeacherBalanceCubit extends Cubit<WithDrawTeacherBalanceState> {
  WithDrawTeacherBalanceCubit(
      {required WithDrawalTeacherBalanceRepo withdrawalRepo})
      : _withdrawalRepo = withdrawalRepo,
        super(const WithDrawBalanceInitial());

  final WithDrawalTeacherBalanceRepo _withdrawalRepo;

  Future<void> requestWithdrawal({
    required double amount,
    required String issuer,
    required String mobileNumber,
    required String idempotencyKey,
  }) async {
    if (state is WithDrawBalanceLoading) return;

    emit(const WithDrawBalanceLoading());
    final result = await _withdrawalRepo.requestWithdrawal(
      amount: amount,
      issuer: issuer,
      mobileNumber: mobileNumber,
      idempotencyKey: idempotencyKey,
    );

    result.fold(
      (failure) => emit(WithDrawBalanceFailure(errMessage: failure.message)),
      (withdrawal) => emit(WithDrawBalanceSuccess(result: withdrawal)),
    );
  }

  Future<void> reconcileWithdrawal({required String withdrawalId}) async {
    if (withdrawalId.trim().isEmpty) {
      emit(const ReconcileTransactionFailure(
        transactionId: '',
        errMessage: 'Withdrawal ID is required.',
      ));
      return;
    }

    emit(ReconcileTransactionLoading(transactionId: withdrawalId));
    final result =
        await _withdrawalRepo.reconcileWithdrawal(withdrawalId: withdrawalId);

    result.fold(
      (failure) => emit(ReconcileTransactionFailure(
        transactionId: withdrawalId,
        errMessage: failure.message,
      )),
      (withdrawal) => emit(ReconcileTransactionSuccess(result: withdrawal)),
    );
  }
}
