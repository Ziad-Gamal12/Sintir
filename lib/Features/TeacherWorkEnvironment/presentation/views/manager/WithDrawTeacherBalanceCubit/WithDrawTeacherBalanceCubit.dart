import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PayoutRepo.dart';
import 'package:sintir/Core/repos/TeacherTranscationsRepo/TeacherTranscationsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';
import 'package:sintir/locale_keys.dart';

part 'TransactionsState.dart';

class WithDrawTeacherBalanceCubit extends Cubit<WithDrawTeacherBalanceState> {
  // Added PaymobPayoutRepo for status checking
  WithDrawTeacherBalanceCubit({
    required this.teacherWalletRepo,
    required this.transcationsRepo,
    required this.paymobPayoutRepo,
  }) : super(UpdateTeacherWalletInitial());

  final TeacherWalletRepo teacherWalletRepo;
  final TeacherTranscationsRepo transcationsRepo;
  final PayoutRepo paymobPayoutRepo;

  Future<void> updateTeacherWalletBalance(
      {required String teacherId, required double balance}) async {
    emit(UpdateTeacherWalletLoading());
    final result = await teacherWalletRepo.updateTeacherWalletBalance(
        teacherId: teacherId, balance: balance);
    result.fold((l) => emit(UpdateTeacherWalletFailure(errMessage: l.message)),
        (r) => emit(UpdateTeacherWalletSuccess()));
  }

  Future<void> storeTransaction(
      {required TransactionEntity transaction, required String userId}) async {
    emit(StoreTransactionLoading());
    final result = await transcationsRepo.storeTransaction(
        transaction: transaction, userId: userId);
    result.fold((l) => emit(StoreTransactionFailure(errMessage: l.message)),
        (r) => emit(StoreTransactionSuccess()));
  }

  // Helper function to handle consistent error emission
  void _emitFailure({
    required String transactionId,
    required String message,
  }) {
    emit(ReconcileTransactionFailure(
      transactionId: transactionId,
      errMessage: message,
    ));
  }

  Future<void> reconcileTransactionStatus({
    required TransactionEntity transaction,
    required String userId,
  }) async {
    final transactionId = transaction.transactionId;
    if (transactionId.isEmpty) {
      return _emitFailure(
        transactionId: transactionId,
        message: LocaleKeys.reconcileMissingIdError,
      );
    }

    emit(ReconcileTransactionLoading(transactionId: transactionId));

    final statusCheckResult = await paymobPayoutRepo.getDisbursementStatus(
      transactionId: transactionId,
    );

    await statusCheckResult.fold(
      (failure) {
        _emitFailure(
          transactionId: transactionId,
          message: LocaleKeys.reconcileStatusCheckFailed(failure.message),
        );
      },
      (paymobStatusResponse) async {
        final newStatus =
            (paymobStatusResponse["disbursement_status"] as String?)
                    ?.toUpperCase() ??
                'UNKNOWN';
        final statusDescription =
            (paymobStatusResponse["status_description"] as String?) ??
                'No description provided.';

        final updateStatusResult = await transcationsRepo.reconcileTransaction(
          transaction: transaction,
          userId: userId,
          newStatus: newStatus,
        );

        await updateStatusResult.fold(
          (dbFailure) {
            _emitFailure(
              transactionId: transactionId,
              message: LocaleKeys.reconcileDbUpdateFailed(
                message: dbFailure.message,
                status: newStatus,
                description: statusDescription,
              ),
            );
          },
          (_) async {
            if (newStatus == 'FAILED' || newStatus == 'REJECTED') {
              _emitFailure(
                transactionId: transactionId,
                message: LocaleKeys.reconcileTransactionFailedMessage(
                    statusDescription),
              );
            } else {
              emit(ReconcileTransactionSuccess(transactionId: transactionId));
            }
          },
        );
      },
    );
  }
}
