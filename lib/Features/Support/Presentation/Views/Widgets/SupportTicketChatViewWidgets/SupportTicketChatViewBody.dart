import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/SupportTicketChatViewWidgets/CustomChatTextField.dart';

class SupportTicketChatViewBody extends StatefulWidget {
  const SupportTicketChatViewBody({super.key});

  @override
  State<SupportTicketChatViewBody> createState() =>
      _SupportTicketChatViewBodyState();
}

class _SupportTicketChatViewBodyState extends State<SupportTicketChatViewBody> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container()),
        const Positioned(
            left: 0, right: 0, bottom: 0, child: CustomSupportChatTextField())
      ],
    );
  }
}
