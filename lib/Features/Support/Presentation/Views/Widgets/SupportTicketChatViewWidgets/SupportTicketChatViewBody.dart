import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/CustomSupportChatSendMessageSection.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/SupportChatMessagesListView.dart';

class SupportTicketChatViewBody extends StatelessWidget {
  const SupportTicketChatViewBody(
      {super.key, required this.supportTicketEntity});
  final SupportTicketEntity supportTicketEntity;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
            child: SupportChatMessagesListView(
          ticketID: supportTicketEntity.id,
        )),
        Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomSupportChatSendMessageSection(
              ticketId: supportTicketEntity.id,
            ))
      ],
    );
  }
}
