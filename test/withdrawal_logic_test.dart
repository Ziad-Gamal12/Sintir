import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/TransactionModel.dart';
import 'package:sintir/Core/services/WithdrawalIdempotency.dart';
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
  Completer<Either<Failure, TeacherWithdrawalResultEntity>>? createCompleter;
  final List<String> idempotencyKeys = <String>[];

  @override
  Future<Either<Failure, TeacherWithdrawalResultEntity>> requestWithdrawal({
    required double amount,
    required String issuer,
    required String mobileNumber,
    required String idempotencyKey,
  }) async {
    createCalls++;
    idempotencyKeys.add(idempotencyKey);
    if (createCompleter != null) return createCompleter!.future;
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
  group('Withdrawal request idempotency lifecycle', () {
    const firstKey = '2bbdc5fd-f4a5-478d-9a1f-3b130b3bf8cf';
    const secondKey = '6942e892-a038-4d65-9d88-7bbcd359dfd6';

    test('consecutive deliberate withdrawals get independent keys', () {
      final first = WithdrawalRequestSnapshot.resolve(
        saved: null,
        proposedKey: firstKey,
        amount: 100,
        issuer: 'vodafone',
        mobileNumber: '01012345678',
      );
      final second = WithdrawalRequestSnapshot.resolve(
        saved: null,
        proposedKey: secondKey,
        amount: 100,
        issuer: 'vodafone',
        mobileNumber: '01012345678',
      );

      expect(first.idempotencyKey, isNot(second.idempotencyKey));
    });

    test('timeout retry reuses the persisted key and exact request details', () {
      final first = WithdrawalRequestSnapshot.resolve(
        saved: null,
        proposedKey: firstKey,
        amount: 125,
        issuer: 'orange',
        mobileNumber: '01212345678',
      );
      final retry = WithdrawalRequestSnapshot.resolve(
        saved: first.encode(),
        proposedKey: secondKey,
        amount: 125,
        issuer: 'orange',
        mobileNumber: '01212345678',
      );

      expect(retry.idempotencyKey, firstKey);
      expect(retry.amount, 125);
      expect(retry.issuer, 'orange');
      expect(retry.mobileNumber, '01212345678');
    });

    test('completed withdrawal releases its snapshot for a new request', () {
      expect(withdrawalRequestIsResolved('SUCCESS'), isTrue);
      expect(withdrawalRequestIsResolved('FAILED'), isTrue);
      expect(withdrawalRequestIsResolved('PROCESSING_UNKNOWN'), isFalse);
      final next = WithdrawalRequestSnapshot.resolve(
        saved: null,
        proposedKey: secondKey,
        amount: 100,
        issuer: 'etisalat',
        mobileNumber: '01112345678',
      );

      expect(next.idempotencyKey, secondKey);
      expect(next.idempotencyKey, isNot(firstKey));
    });

    test('same key cannot be retried with changed payout details', () {
      final first = WithdrawalRequestSnapshot.resolve(
        saved: null,
        proposedKey: firstKey,
        amount: 125,
        issuer: 'vodafone',
        mobileNumber: '01012345678',
      );

      expect(
        () => WithdrawalRequestSnapshot.resolve(
          saved: first.encode(),
          proposedKey: secondKey,
          amount: 125,
          issuer: 'vodafone',
          mobileNumber: '01087654321',
        ),
        throwsStateError,
      );
    });
  });

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
    test('ignores a second withdrawal submit while the first is in flight', () async {
      final repo = _FakeWithdrawalRepo()
        ..createCompleter =
            Completer<Either<Failure, TeacherWithdrawalResultEntity>>();
      final cubit = WithDrawTeacherBalanceCubit(withdrawalRepo: repo);

      final first = cubit.requestWithdrawal(
        amount: 100,
        issuer: 'vodafone',
        mobileNumber: '01012345678',
        idempotencyKey: 'first-key',
      );
      await cubit.requestWithdrawal(
        amount: 100,
        issuer: 'vodafone',
        mobileNumber: '01012345678',
        idempotencyKey: 'second-key',
      );

      expect(repo.createCalls, 1);
      expect(repo.idempotencyKeys, ['first-key']);
      repo.createCompleter!.complete(right(const TeacherWithdrawalResultEntity(
        withdrawalId: 'withdrawal-id',
        status: 'PENDING',
      )));
      await first;
      await cubit.close();
    });

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
