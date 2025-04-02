import 'package:sintir/Core/entities/PaymentEntities/BillingDataEntity.dart';

class Paymentdataentity {
  final String currency;
  final Billingdataentity billingdataentity;
  final int priceCents, expiration, integrationId;
  int? orderId;
  String? authToken;

  Paymentdataentity(
      {this.authToken,
      required this.billingdataentity,
      required this.currency,
      required this.priceCents,
      required this.expiration,
      this.orderId,
      required this.integrationId});
}
