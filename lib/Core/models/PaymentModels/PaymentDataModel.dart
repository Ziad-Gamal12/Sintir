import 'package:sintir/Core/entities/PaymentEntities/PaymentDataEntity.dart';
import 'package:sintir/Core/models/PaymentModels/BillingDataModel.dart';

class Paymentdatamodel {
  final String authToken, currency;
  final Map<String, dynamic> billingdataentity;
  final int priceCents, expiration, orderId, integrationId;

  Paymentdatamodel(
      {required this.authToken,
      required this.currency,
      required this.billingdataentity,
      required this.priceCents,
      required this.expiration,
      required this.orderId,
      required this.integrationId});

  factory Paymentdatamodel.fromJson(Map<String, dynamic> json) {
    return Paymentdatamodel(
      authToken: json['auth_token'],
      currency: json['currency'],
      billingdataentity: json['billing_data'],
      priceCents: json['amount_cents'],
      expiration: json['expiration'],
      orderId: json['order_id'],
      integrationId: json['integration_id'],
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
      integrationId: entity.integrationId,
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
      integrationId: integrationId,
    );
  }

  Map<String, dynamic> toJson() => {
        'auth_token': authToken,
        'currency': currency,
        'billing_data': billingdataentity,
        'amount_cents': priceCents,
        'expiration': expiration,
        'order_id': orderId,
        'integration_id': integrationId,
      };
}
