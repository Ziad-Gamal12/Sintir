import 'package:sintir/Features/Support/Domain/Entities/SupportSenderEntity.dart';

class CustomSupportTicketChatEntity {
  String message;
  final SupportSenderEntity sender;
  String? image;
  final DateTime createdAt;

  CustomSupportTicketChatEntity(
      {required this.sender,
      required this.createdAt,
      required this.message,
      this.image});
}
