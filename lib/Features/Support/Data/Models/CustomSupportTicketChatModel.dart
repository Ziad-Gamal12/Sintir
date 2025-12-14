import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sintir/Features/Support/Data/Models/SupportSenderModel.dart';
import 'package:sintir/Features/Support/Domain/Entities/CustomSupportTicketChatEntity.dart';

class CustomSupportTicketChatModel {
  final String message;
  final Map<String, dynamic> sender;
  final String? image;
  final DateTime createdAt;

  CustomSupportTicketChatModel(
      {required this.message,
      required this.sender,
      required this.image,
      required this.createdAt});
  factory CustomSupportTicketChatModel.fromJson(Map<String, dynamic> json) {
    return CustomSupportTicketChatModel(
      message: json['message'],
      sender: json['sender'],
      image: json['image'],
      createdAt: (json['createdAt'] as Timestamp).toDate(),
    );
  }
  factory CustomSupportTicketChatModel.fromEntity(
      CustomSupportTicketChatEntity entity) {
    return CustomSupportTicketChatModel(
      message: entity.message,
      sender: SupportSenderModel.fromEntity(entity.sender).toJson(),
      image: entity.image,
      createdAt: entity.createdAt,
    );
  }
  CustomSupportTicketChatEntity toEntity() {
    return CustomSupportTicketChatEntity(
      message: message,
      sender: SupportSenderModel.fromJson(sender).toEntity(),
      image: image,
      createdAt: createdAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'message': message,
      'sender': sender,
      'image': image,
      'createdAt': createdAt,
    };
  }
}
