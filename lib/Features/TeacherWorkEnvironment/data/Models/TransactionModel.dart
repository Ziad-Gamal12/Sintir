import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Entities/TransactionEntity.dart';

class TransactionModel {
  final String? transactionId;
  final DateTime? createdAt;
  final double? amount;
  final String? currency;
  final String? issuer;
  final String? mobile;
  final String? status;
  TransactionModel(
      {required this.transactionId,
      required this.createdAt,
      required this.amount,
      required this.currency,
      required this.issuer,
      required this.mobile,
      required this.status});

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transaction_id'],
      createdAt: (json['created_at'] as Timestamp).toDate(),
      amount: json['amount'],
      currency: json['currency'],
      issuer: json['issuer'],
      mobile: json['mobile'],
      status: json['status'],
    );
  }
  factory TransactionModel.fromEntity(TransactionEntity entity) {
    return TransactionModel(
      transactionId: entity.transactionId,
      createdAt: entity.createdAt,
      amount: entity.amount,
      currency: entity.currency,
      issuer: entity.issuer,
      mobile: entity.mobileNumber,
      status: entity.status,
    );
  }
  TransactionEntity toEntity() {
    return TransactionEntity(
      transactionId: transactionId,
      createdAt: createdAt,
      amount: amount,
      currency: currency,
      issuer: issuer,
      mobileNumber: mobile,
      status: status,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'created_at': createdAt,
      'amount': amount,
      'currency': currency,
      'issuer': issuer,
      'mobile': mobile,
      'status': status,
    };
  }
}
