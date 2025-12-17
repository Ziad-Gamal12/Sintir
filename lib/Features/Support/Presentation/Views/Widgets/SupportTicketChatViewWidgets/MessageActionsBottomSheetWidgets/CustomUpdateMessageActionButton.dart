import 'package:flutter/material.dart';
import 'package:sintir/Core/helper/ShowBottomSheet.dart';
import 'package:sintir/Core/widgets/CustomButton.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportChatMessageEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/UpdateMessageBottomSheetWidgets/UpdateMessageBottomSheet.dart';
import 'package:sintir/locale_keys.dart';

class CustomUpdateMessageActionButton extends StatelessWidget {
  const CustomUpdateMessageActionButton(
      {super.key, required this.ticketId, required this.messageEntity});
  final String ticketId;
  final SupportChatMessageEntity messageEntity;
  @override
  Widget build(BuildContext context) {
    return Custombutton(
        text: LocaleKeys.updatedMessage,
        color: Colors.transparent,
        side: const BorderSide(
          width: 1,
          color: Colors.grey,
        ),
        textColor: Colors.white,
        onPressed: () {
          showCustomModalBottomSheet(
              child: UpdateMessageBottomSheet(
                  ticketId: ticketId, messageEntity: messageEntity),
              context: context);
        });
  }
}
