// ignore_for_file: file_names

import 'package:sintir/Core/entities/PaymentEntities/OrderDataEntity.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/models/PaymentModels/OrderItemModel.dart';

class Orderdatamodel {
  final String authToken;
  final bool deliveryNeeded;
  final int priceCents;
  final String currency;
  final String merchantOrderId;
  final List<Map<String, dynamic>> items;

  Orderdatamodel(
      {required this.authToken,
      required this.deliveryNeeded,
      required this.priceCents,
      required this.currency,
      required this.merchantOrderId,
      required this.items});

  factory Orderdatamodel.fromJson(Map<String, dynamic> json) => Orderdatamodel(
        authToken: json["auth_token"],
        deliveryNeeded: json["delivery_needed"],
        priceCents: json["amount_cents"],
        currency: json["currency"],
        merchantOrderId: json["merchant_order_id"],
        items: (json["items"] as List<Map<String, dynamic>>)
            .map((x) => Coursemodel.fromJson(x).toJson())
            .toList(),
      );
  factory Orderdatamodel.fromEntity(Orderdataentity entity) => Orderdatamodel(
        authToken: entity.authToken!,
        deliveryNeeded: entity.deliveryNeeded,
        priceCents: entity.priceCents,
        currency: entity.currency,
        merchantOrderId: entity.merchantOrderId,
        items: entity.items
            .map((e) => Orderitemmodel.fromCourseEntity(e).toJson())
            .toList(),
      );
  Map<String, dynamic> toJson() => {
        "delivery_needed": deliveryNeeded,
        "amount_cents": priceCents,
        "currency": currency,
        "merchant_order_id": merchantOrderId,
        "items": items,
      };
}
