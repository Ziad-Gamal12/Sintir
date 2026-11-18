import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/RealtimeDataBaseService.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Repos/TeacherLiveWalletRepo.dart';

const teacherId = 'teacher-1';

/// A `Users/{teacherId}` document as Firestore returns it.
Map<String, dynamic> userDocument({
  double balance = 1323,
  double payoutPending = 250,
  String firstName = 'Teacher',
}) => {
  'uid': teacherId,
  'firstName': firstName,
  'role': 'teacher',
  'teacherExtraData': {
    'subject': 'Math',
    'workExperience': '5',
    'wallet': {
      'wallet_id': 7,
      'teacher_id': teacherId,
      'balance': balance,
      'total_earned': 5000,
      'payout_pending': payoutPending,
      'currency': 'EGP',
      'status': 'active',
      'created_at': Timestamp.fromDate(DateTime.utc(2024)),
      'updated_at': Timestamp.fromDate(DateTime.utc(2024, 5)),
      'last_transaction_id': 'tx-1',
    },
  },
};

TeacherWalletEntity wallet({
  double balance = 1323,
  double payoutPending = 250,
  String status = 'active',
}) => TeacherWalletEntity(
  walletId: 7,
  teacherId: teacherId,
  balance: balance,
  totalEarned: 5000,
  payoutPending: payoutPending,
  currency: 'EGP',
  status: status,
  createdAt: DateTime.utc(2024),
  updatedAt: DateTime.utc(2024, 5),
  lastTransactionId: 'tx-1',
);

/// Hands the repo a stream the test drives by hand.
class FakeRealtimeDataBaseService implements RealtimeDataBaseService {
  final controller = StreamController<Map<String, dynamic>?>();
  FireStoreRequirmentsEntity? lastRequirements;

  @override
  Stream<Map<String, dynamic>?> watchDocument({
    required FireStoreRequirmentsEntity requirements,
  }) {
    lastRequirements = requirements;
    return controller.stream;
  }
}

/// Each `watchWallet` call gets its own controller so tests can check that
/// retries cancel the previous listener.
class FakeTeacherLiveWalletRepo implements TeacherLiveWalletRepo {
  final controllers =
      <StreamController<Either<Failure, TeacherWalletEntity>>>[];
  final requestedTeacherIds = <String>[];

  int get watchCalls => controllers.length;
  StreamController<Either<Failure, TeacherWalletEntity>> get latest =>
      controllers.last;

  void emitWallet(TeacherWalletEntity value) => latest.add(Right(value));
  void emitFailure(String message) =>
      latest.add(Left(ServerFailure(message: message)));

  @override
  Stream<Either<Failure, TeacherWalletEntity>> watchWallet({
    required String teacherId,
  }) {
    requestedTeacherIds.add(teacherId);
    final controller = StreamController<Either<Failure, TeacherWalletEntity>>();
    controllers.add(controller);
    return controller.stream;
  }
}
