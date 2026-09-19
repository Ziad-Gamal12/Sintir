import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/TransactionEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/Helper/TreacherWalletTransactionItemHelper.dart';
import 'package:sintir/locale_keys.dart';

class TeacherWalletTransactionItemRequirements {
  final TransactionEntity transaction;
  final String teacherId;
  late final TreacherWalletTransactionItemHelper _helper;

  TeacherWalletTransactionItemRequirements(
      {required this.transaction, required this.teacherId}) {
    _helper = TreacherWalletTransactionItemHelper();
  }

  String get issuerPath => _helper.getIssuerSVGPath(issuer: transaction.issuer);
  Color get issuerColor => _helper.getIssuerColor(issuer: transaction.issuer);
  Color get statusColor => _helper.getStatusColor(status: transaction.status);
  String get statusLabel => _helper.getStatusLabel(status: transaction.status);
  String get issuerLabel => _helper.getIssuerLabel(issuer: transaction.issuer);
  String get mobileNumber => transaction.mobileNumber ?? '';
  String get amountLabel =>
      '- ${_helper.formatAmount(amount: transaction.amount)} ${_helper.getCurrencyLabel(currency: transaction.currency)}';
  String dateLabel(BuildContext context) =>
      _helper.formatDate(context, createdAt: transaction.createdAt);
  String get transactionTypeLabel => LocaleKeys.withdrawalRequestTitle;
  String get paymentMethodLabel =>
      _helper.getIssuerLabel(issuer: transaction.issuer);
  String get issuerBrandName =>
      _helper.getIssuerBrandName(issuer: transaction.issuer);
  String get reconciliationStatusLabel => _helper.getReconciliationStatusLabel(
      isReconciled: transaction.isReconciled);
  String get transactionId => transaction.transactionId;
}
