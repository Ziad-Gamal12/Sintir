class TransactionEntity {
  String? transactionId;
  final DateTime? createdAt;
  final double? amount;
  final String? currency;
  final String? issuer;
  final String? mobileNumber;
  final String? status;

  TransactionEntity(
      {required this.transactionId,
      required this.createdAt,
      required this.amount,
      required this.currency,
      required this.issuer,
      required this.mobileNumber,
      required this.status});

  TransactionEntity copyWith({
    String? transactionId,
    DateTime? createdAt,
    double? amount,
    String? currency,
    String? issuer,
    String? mobileNumber,
    String? status,
  }) {
    return TransactionEntity(
      transactionId: transactionId ?? this.transactionId,
      createdAt: createdAt ?? this.createdAt,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      issuer: issuer ?? this.issuer,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      status: status ?? this.status,
    );
  }
}
