// ignore_for_file: file_names

import 'package:sintir/Features/Subscribtion/Domain/Entities/PaymentEntities/BillingDataEntity.dart';

class Billingdatamodel {
  final String firstName,
      lastName,
      email,
      phoneNumber,
      street,
      building,
      floor,
      apartment,
      city,
      country;

  Billingdatamodel(
      {required this.firstName,
      required this.lastName,
      required this.email,
      required this.phoneNumber,
      required this.street,
      required this.building,
      required this.floor,
      required this.apartment,
      required this.city,
      required this.country});

  factory Billingdatamodel.fromJson(Map<String, dynamic> json) {
    return Billingdatamodel(
      firstName: json['first_name'],
      lastName: json['last_name'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      street: json['street'],
      building: json['building'],
      floor: json['floor'],
      apartment: json['apartment'],
      city: json['city'],
      country: json['country'],
    );
  }
  factory Billingdatamodel.fromEntity({required Billingdataentity entity}) {
    return Billingdatamodel(
      firstName: entity.firstName,
      lastName: entity.lastName,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      street: entity.street,
      building: entity.building,
      floor: entity.floor,
      apartment: entity.apartment,
      city: entity.city,
      country: entity.country,
    );
  }

  Billingdataentity toEntity() {
    return Billingdataentity(
        firstName: firstName,
        lastName: lastName,
        email: email,
        phoneNumber: phoneNumber,
        street: street,
        building: building,
        floor: floor,
        apartment: apartment,
        city: city,
        country: country);
  }

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "phone_number": phoneNumber,
        "street": street,
        "building": building,
        "floor": floor,
        "apartment": apartment,
        "city": city,
        "country": country
      };
}
