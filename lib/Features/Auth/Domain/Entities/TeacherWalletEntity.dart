import 'package:sintir/Core/utils/Backend_EndPoints.dart';

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
}
