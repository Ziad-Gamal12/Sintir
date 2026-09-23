import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWithdrawalResultEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';

part 'WithDrawTeacherBalanceState.dart';

class WithDrawTeacherBalanceCubit extends Cubit<WithDrawTeacherBalanceState> {
  WithDrawTeacherBalanceCubit({
    required WithDrawalTeacherBalanceRepo withdrawalRepo,
  })  : _withdrawalRepo = withdrawalRepo,
        super(const WithDrawBalanceInitial());

  final WithDrawalTeacherBalanceRepo _withdrawalRepo;
  bool _requestInFlight = false;
  final Set<String> _reconcilingWithdrawalIds = <String>{};

  Future<void> requestWithdrawal({
    required double amount,
    required String issuer,
    required String mobileNumber,
    required String idempotencyKey,
  }) async {
    if (_requestInFlight) return;

    _requestInFlight = true;
    emit(const WithDrawBalanceLoading());
    try {
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
    } catch (_) {
      emit(const WithDrawBalanceFailure(
        errMessage: 'Unable to submit the withdrawal. Please try again.',
      ));
    } finally {
      _requestInFlight = false;
    }
  }

  Future<void> reconcileWithdrawal({required String withdrawalId}) async {
    final id = withdrawalId.trim();
    if (id.isEmpty) {
      emit(const ReconcileTransactionFailure(
        transactionId: '',
        errMessage: 'Withdrawal ID is required.',
      ));
      return;
    }
    if (!_reconcilingWithdrawalIds.add(id)) return;

    emit(ReconcileTransactionLoading(transactionId: id));
    try {
      final result =
          await _withdrawalRepo.reconcileWithdrawal(withdrawalId: id);
      result.fold(
        (failure) => emit(ReconcileTransactionFailure(
          transactionId: id,
          errMessage: failure.message,
        )),
        (withdrawal) => emit(ReconcileTransactionSuccess(result: withdrawal)),
      );
    } catch (_) {
      emit(ReconcileTransactionFailure(
        transactionId: id,
        errMessage: 'Unable to check this withdrawal right now.',
      ));
    } finally {
      _reconcilingWithdrawalIds.remove(id);
    }
  }
}
