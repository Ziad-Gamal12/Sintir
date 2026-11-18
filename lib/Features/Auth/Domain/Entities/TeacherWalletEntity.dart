import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Auth/Domain/Entities/TeacherWalletStatus.dart';

class TeacherWalletEntity {
  final int walletId;
  String teacherId;
  final double balance;
  final double totalEarned;
  final double payoutPending;
  final String currency;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String? lastTransactionId;

  TeacherWalletEntity({
    required this.walletId,
    required this.teacherId,
    required this.balance,
    required this.totalEarned,
    required this.payoutPending,
    required this.currency,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.lastTransactionId,
  });
  static TeacherWalletEntity empty() {
    return TeacherWalletEntity(
        balance: 0,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        currency: "EGP",
        walletId: 123456,
        payoutPending: 0,
        status: BackendEndpoints.walletActive,
        teacherId: '',
        totalEarned: 0);
  }

  TeacherWalletStatus get walletStatus => TeacherWalletStatus.fromRaw(status);

  /// Whether the teacher may start a withdrawal from this wallet.
  bool get canWithdraw => walletStatus.canWithdraw;

  /// Value equality, so live listeners can drop snapshots where the wallet
  /// did not actually change.
  ///
  /// Dates compare by instant: Firestore hands back local `DateTime`s, and
  /// `DateTime ==` would also compare the UTC flag.
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TeacherWalletEntity &&
          other.walletId == walletId &&
          other.teacherId == teacherId &&
          other.balance == balance &&
          other.totalEarned == totalEarned &&
          other.payoutPending == payoutPending &&
          other.currency == currency &&
          other.status == status &&
          other.createdAt.isAtSameMomentAs(createdAt) &&
          other.updatedAt.isAtSameMomentAs(updatedAt) &&
          other.lastTransactionId == lastTransactionId;

  @override
  int get hashCode => Object.hash(
        walletId,
        teacherId,
        balance,
        totalEarned,
        payoutPending,
        currency,
        status,
        createdAt.microsecondsSinceEpoch,
        updatedAt.microsecondsSinceEpoch,
        lastTransactionId,
      );
}
