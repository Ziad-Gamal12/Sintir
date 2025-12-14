// AddSupportTicketInputs.dart

import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/SupportSenderInputs.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/SupportTicketDetailsInputs.dart';

class AddSupportTicketInputs extends StatelessWidget {
  const AddSupportTicketInputs({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SupportSenderInputs(),
        SizedBox(height: 32),
        Divider(
          thickness: 4,
          color: Colors.grey,
          indent: 20,
          endIndent: 20,
        ),
        SizedBox(height: 32),
        SupportTicketDetailsInputs(),
      ],
    );
  }
}
