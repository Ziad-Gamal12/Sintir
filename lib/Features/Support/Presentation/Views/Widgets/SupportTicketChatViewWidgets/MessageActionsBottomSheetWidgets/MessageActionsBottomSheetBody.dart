import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportChatMessageEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/MessageActionsBottomSheetWidgets/CustomDeleteMessageActionButton.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/MessageActionsBottomSheetWidgets/CustomUpdateMessageActionButton.dart';
import 'package:sintir/constant.dart';

class MessageActionsBottomSheetBody extends StatelessWidget {
  const MessageActionsBottomSheetBody(
      {super.key, required this.ticketId, required this.messageEntity});
  final String ticketId;
  final SupportChatMessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: KHorizontalPadding,
        vertical: KVerticalPadding,
      ),
      child: Column(
        children: [
          Container(
            height: 2,
            width: 80,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(8.0),
            ),
          ),
          const SizedBox(height: 16.0),
          CustomUpdateMessageActionButton(
            messageEntity: messageEntity,
            ticketId: ticketId,
          ),
          const SizedBox(height: 16.0),
          CustomDeleteMessageActionButton(
            messageEntity: messageEntity,
            ticketId: ticketId,
          )
        ],
      ),
    );
  }
}
