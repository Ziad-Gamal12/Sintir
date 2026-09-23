import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Enums/TransactionsStatusEnum.dart';

class TransactionModel {
  final String transactionId;
  final DateTime? createdAt;
  final double? amount;
  final String? currency;
  final String? issuer;
  final String? mobile;
  final String? status;
  final bool? isReconciled;
  final String method;
  TransactionModel(
      {required this.transactionId,
      required this.createdAt,
      required this.amount,
      required this.currency,
      required this.isReconciled,
      required this.method,
      required this.issuer,
      required this.mobile,
      required this.status});
  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
          transactionId: json['transaction_id'] as String? ?? '',
          createdAt: _date(json['created_at']),
          amount: _number(json['amount']),
          method: json['method'] as String? ?? '',
          currency: json['currency'] as String?,
          isReconciled: json['isReconciled'] as bool?,
          issuer: json['issuer'] as String?,
          mobile: json['mobile'] as String?,
          status: json['status'] as String?);
  factory TransactionModel.fromEntity(TransactionEntity entity) =>
      TransactionModel(
          transactionId: entity.transactionId,
          createdAt: entity.createdAt,
          amount: entity.amount,
          currency: entity.currency,
          method: entity.method,
          isReconciled: entity.isReconciled,
          issuer: entity.issuer,
          mobile: entity.mobileNumber,
          status: entity.status?.name ?? TransactionsStatus.other.name);
  TransactionEntity toEntity() => TransactionEntity(
      transactionId: transactionId,
      isReconciled: isReconciled,
      createdAt: createdAt,
      method: method,
      amount: amount,
      currency: currency,
      issuer: issuer,
      mobileNumber: mobile,
      status: _status(status));
  Map<String, dynamic> toJson() => {
        'transaction_id': transactionId,
        'created_at': createdAt,
        'amount': amount,
        'isReconciled': isReconciled,
        'currency': currency,
        'issuer': issuer,
        'mobile': mobile,
        'status': status,
        'method': method
      };
  static TransactionsStatus _status(String? raw) {
    switch (raw?.trim().toUpperCase()) {
      case 'SUCCESS':
      case 'SUCCESSFUL':
      case 'COMPLETED':
      case 'APPROVED':
        return TransactionsStatus.success;
      case 'FAILED':
      case 'FAILURE':
      case 'REJECTED':
      case 'CANCELLED':
        return TransactionsStatus.failure;
      case 'RESERVED':
      case 'PENDING':
      case 'PROCESSING_UNKNOWN':
      case 'IN_PROGRESS':
        return TransactionsStatus.pending;
      default:
        // Unknown provider states are non-terminal. Keep the refresh action
        // available rather than leaving funds reserved forever in the UI.
        return TransactionsStatus.pending;
    }
  }

  static DateTime? _date(dynamic value) {
    if (value is Timestamp) return value.toDate();
    if (value is DateTime) return value;
    if (value is String) return DateTime.tryParse(value);
    return null;
  }

  static double? _number(dynamic value) =>
      value is num ? value.toDouble() : null;
}
