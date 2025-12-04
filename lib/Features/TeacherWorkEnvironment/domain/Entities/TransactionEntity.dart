class TransactionEntity {
  String? transactionId;
  final DateTime? createdAt;
  final double? amount;
  final String? currency;
  final String? issuer;
  final String? mobileNumber;
  final String? status;
  final bool? isReconciled;
  TransactionEntity(
      {required this.transactionId,
      required this.createdAt,
      required this.amount,
      required this.currency,
      required this.issuer,
      required this.isReconciled,
      required this.mobileNumber,
      required this.status});

  TransactionEntity copyWith({
    String? transactionId,
    DateTime? createdAt,
    double? amount,
    String? currency,
    String? issuer,
    String? mobileNumber,
    bool? isReconciled,
    String? status,
  }) {
    return TransactionEntity(
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      isReconciled: isReconciled ?? this.isReconciled,
      issuer: issuer ?? this.issuer,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      status: status ?? this.status,
    );
  }
}
