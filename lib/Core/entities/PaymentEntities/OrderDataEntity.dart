// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';

class Orderdataentity {
  String? authToken;
  final bool deliveryNeeded;
  final int priceCents;
  final String currency;
  final String merchantOrderId;
  final List<CourseEntity> items;

  Orderdataentity(
      {this.authToken,
      required this.deliveryNeeded,
      required this.priceCents,
      required this.currency,
      required this.merchantOrderId,
      required this.items});
}
