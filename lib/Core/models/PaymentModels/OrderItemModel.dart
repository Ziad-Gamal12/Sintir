// ignore_for_file: file_names

import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';

class Orderitemmodel {
  final String name, amountcents, quantity, description;

  Orderitemmodel(
      {required this.name,
      required this.amountcents,
      required this.quantity,
      required this.description});
  factory Orderitemmodel.fromJson(Map<String, dynamic> json) {
    return Orderitemmodel(
      name: json['name'],
      amountcents: json['amount_cents'],
      quantity: json['quantity'],
      description: json['description'],
    );
  }
  factory Orderitemmodel.fromCourseEntity(CourseEntity entity, int amount) {
    return Orderitemmodel(
      name: entity.title,
      amountcents: (amount * 100).toString(),
      quantity: "1",
      description: entity.description,
    );
  }
  Map<String, dynamic> toJson() => {
        'name': name,
        'amount': amountcents,
        'quantity': quantity,
        'description': description,
      };
}
