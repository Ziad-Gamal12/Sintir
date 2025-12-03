import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/repos/PaymobPayoutRepo/PayoutRepo.dart';
import 'package:sintir/Core/repos/TranscationsRepo/TranscationsRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TransactionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherWalletRepo.dart';

part 'TransactionsState.dart';

class TransactionsCubit extends Cubit<TransactionsState> {
  // Added PaymobPayoutRepo for status checking
  TransactionsCubit({
    required this.teacherWalletRepo,
    required this.transcationsRepo,
    required this.paymobPayoutRepo,
  }) : super(UpdateTeacherWalletInitial());

  final TeacherWalletRepo teacherWalletRepo;
  final TranscationsRepo transcationsRepo;
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

  Future<void> reconcileTransactionStatus({
    required TransactionEntity transaction,
    required String userId,
  }) async {
    emit(ReconcileTransactionLoading(
        transactionId: transaction.transactionId ?? ""));

    try {
      final statusCheckResult = await paymobPayoutRepo.getDisbursementStatus(
        transactionId: transaction.transactionId ?? '',
      );

      await statusCheckResult.fold(
        (failure) {
          emit(ReconcileTransactionFailure(
            transactionId: transaction.transactionId ?? '',
            errMessage: 'Paymob check failed: ${failure.message}',
          ));
        },
        (paymobStatusResponse) async {
          final newStatus =
              paymobStatusResponse["disbursement_status"].toUpperCase();

          final updateStatusResult =
              await transcationsRepo.reconcileTransactionStatus(
            transactionId: transaction.transactionId ?? '',
            userId: userId,
            newStatus: newStatus,
          );

          await updateStatusResult.fold(
            (failure) {
              emit(ReconcileTransactionFailure(
                transactionId: transaction.transactionId ?? "",
                errMessage:
                    'DB update failed: ${failure.message}. Paymob status: $newStatus',
              ));
            },
            (r) async {
              if (newStatus == 'FAILED' || newStatus == 'REJECTED') {
                emit(ReconcileTransactionFailure(
                  transactionId: transaction.transactionId ?? "",
                  errMessage: paymobStatusResponse["status_description"],
                ));
              } else {
                emit(ReconcileTransactionSuccess(
                    transactionId: transaction.transactionId ?? ""));
              }
            },
          );
        },
      );
    } catch (e) {
      emit(ReconcileTransactionFailure(
        transactionId: transaction.transactionId ?? "",
        errMessage: 'An unknown error occurred during reconciliation.',
      ));
    }
  }
}
