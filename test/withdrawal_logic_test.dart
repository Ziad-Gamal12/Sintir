import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/TransactionModel.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TeacherWithdrawalResultEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/WithDrawalTeacherBalanceRepo.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/WithDrawTeacherBalanceCubit/WithDrawTeacherBalanceCubit.dart';

class _FakeWithdrawalRepo implements WithDrawalTeacherBalanceRepo {
  _FakeWithdrawalRepo({this.createResult, this.reconcileResult});

  final Either<Failure, TeacherWithdrawalResultEntity>? createResult;
  final Either<Failure, TeacherWithdrawalResultEntity>? reconcileResult;
  int createCalls = 0;
  int reconcileCalls = 0;

  @override
  Future<Either<Failure, TeacherWithdrawalResultEntity>> requestWithdrawal({
    required double amount,
    required String issuer,
    required String mobileNumber,
    required String idempotencyKey,
  }) async {
    createCalls++;
    return createResult ?? left(ServerFailure(message: 'create failed'));
  }

  @override
  Future<Either<Failure, TeacherWithdrawalResultEntity>> reconcileWithdrawal({
    required String withdrawalId,
  }) async {
    reconcileCalls++;
    return reconcileResult ?? left(ServerFailure(message: 'reconcile failed'));
  }
}

void main() {
  group('TransactionModel', () {
    test('keeps unknown non-terminal provider statuses refreshable', () {
      final transaction = TransactionModel.fromJson({
        'transaction_id': 'withdrawal-id',
        'status': 'QUEUED_BY_PROVIDER',
        'method': 'PayOut',
      }).toEntity();

      expect(transaction.status, TransactionsStatus.pending);
    });

    test('maps final provider statuses correctly', () {
      final failed = TransactionModel.fromJson({
        'transaction_id': 'withdrawal-id',
        'status': 'FAILED',
        'method': 'PayOut',
      }).toEntity();
      final successful = TransactionModel.fromJson({
        'transaction_id': 'withdrawal-id',
        'status': 'COMPLETED',
        'method': 'PayOut',
      }).toEntity();

      expect(failed.status, TransactionsStatus.failure);
      expect(successful.status, TransactionsStatus.success);
    });

    test('copyWith preserves and can replace the payout method', () {
      final original = TransactionEntity(
        transactionId: 'id',
        createdAt: null,
        amount: 100,
        currency: 'EGP',
        issuer: 'vodafone',
        method: 'PayOut',
        isReconciled: false,
        mobileNumber: '01000000000',
        status: TransactionsStatus.pending,
      );

      expect(original.copyWith().method, 'PayOut');
      expect(original.copyWith(method: 'Manual').method, 'Manual');
    });
  });

  group('WithDrawTeacherBalanceCubit', () {
    test('emits a successful reconciliation result', () async {
      final repo = _FakeWithdrawalRepo(
        reconcileResult: right(const TeacherWithdrawalResultEntity(
          withdrawalId: 'withdrawal-id',
          status: 'FAILED',
          message: 'Balance restored.',
        )),
      );
      final cubit = WithDrawTeacherBalanceCubit(withdrawalRepo: repo);

      await cubit.reconcileWithdrawal(withdrawalId: 'withdrawal-id');

      expect(repo.reconcileCalls, 1);
      expect(cubit.state, isA<ReconcileTransactionSuccess>());
      await cubit.close();
    });

    test('rejects an empty reconciliation ID without calling the backend',
        () async {
      final repo = _FakeWithdrawalRepo();
      final cubit = WithDrawTeacherBalanceCubit(withdrawalRepo: repo);

      await cubit.reconcileWithdrawal(withdrawalId: '   ');

      expect(repo.reconcileCalls, 0);
      expect(cubit.state, isA<ReconcileTransactionFailure>());
      await cubit.close();
    });
  });
}
