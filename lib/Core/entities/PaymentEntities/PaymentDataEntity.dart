// ignore_for_file: file_names

import 'package:sintir/Core/entities/PaymentEntities/BillingDataEntity.dart';

class Paymentdataentity {
  final String currency;
  final Billingdataentity billingdataentity;
  final int priceCents, expiration;
  final List<int> methods;
  String? authToken, orderId;

  Paymentdataentity(
      {this.authToken,
      required this.billingdataentity,
      required this.currency,
      required this.priceCents,
      required this.methods,
      this.orderId,
      required this.expiration});
}
