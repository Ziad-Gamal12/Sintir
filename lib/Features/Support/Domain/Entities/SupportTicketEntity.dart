import 'package:sintir/Features/Support/Domain/Entities/SupportSenderEntity.dart';

class SupportTicketEntity {
  SupportSenderEntity sender;
  final String id;
  String title;
  String category;
  String description;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;

  SupportTicketEntity(
      {required this.sender,
      required this.id,
      required this.title,
      required this.category,
      required this.description,
      required this.createdAt,
      required this.updatedAt,
      required this.status});
  static List<SupportTicketEntity> fakeSupportTickets() {
    return List.generate(
      6,
      (index) => SupportTicketEntity(
        sender: SupportSenderEntity.empty(),
        id: 'id',
        title: 'title',
        category: 'category',
        description: 'description',
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        status: 'status',
      ),
    );
  }
}
