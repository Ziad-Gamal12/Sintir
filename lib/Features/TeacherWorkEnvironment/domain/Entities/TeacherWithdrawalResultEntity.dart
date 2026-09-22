class TeacherWithdrawalResultEntity {
  const TeacherWithdrawalResultEntity(
      {required this.withdrawalId,
      required this.status,
      this.paymobTransactionId,
      this.message});
  final String withdrawalId;
  final String status;
  final String? paymobTransactionId;
  final String? message;
}
