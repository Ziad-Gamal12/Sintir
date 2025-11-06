// ignore_for_file: file_names

import 'package:sintir/Features/Subscribtion/Data/Models/PaymentModels/BillingDataModel.dart';
import 'package:sintir/Features/Subscribtion/Domain/Entities/PaymentEntities/PaymentDataEntity.dart';

class Paymentdatamodel {
  final String authToken, orderId, currency;
  final Map<String, dynamic> billingdataentity;
  final int priceCents, expiration;
  final List<int> methods;

  Paymentdatamodel({
    required this.authToken,
    required this.currency,
    required this.billingdataentity,
    required this.priceCents,
    required this.expiration,
    required this.orderId,
    required this.methods,
  });

  factory Paymentdatamodel.fromJson(Map<String, dynamic> json) {
    return Paymentdatamodel(
      authToken: json['auth_token'],
      currency: json['currency'],
      billingdataentity: json['billing_data'],
      priceCents: json['amount_cents'],
      expiration: json['expiration'],
      orderId: json['order_id'],
      methods: json['payment_methods'],
    );
  }
  factory Paymentdatamodel.formEntity(Paymentdataentity entity) {
    return Paymentdatamodel(
      authToken: entity.authToken!,
      currency: entity.currency,
      billingdataentity:
          Billingdatamodel.fromEntity(entity: entity.billingdataentity)
              .toJson(),
      priceCents: entity.priceCents,
      expiration: entity.expiration,
      orderId: entity.orderId!,
      methods: entity.methods,
    );
  }
  Paymentdataentity toEntity() {
    return Paymentdataentity(
      authToken: authToken,
      currency: currency,
      billingdataentity:
          Billingdatamodel.fromJson(billingdataentity).toEntity(),
      priceCents: priceCents,
      expiration: expiration,
      orderId: orderId,
      methods: methods,
    );
  }

  Map<String, dynamic> toJson() => {
        'currency': currency,
        'billing_data': billingdataentity,
        'amount': priceCents,
        'expiration': expiration,
        'order_id': orderId,
        'payment_methods': methods,
      };
}
