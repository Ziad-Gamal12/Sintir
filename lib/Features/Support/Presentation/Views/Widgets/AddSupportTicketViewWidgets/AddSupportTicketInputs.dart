// AddSupportTicketInputs.dart

import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/SupportSenderInputs.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/AddSupportTicketViewWidgets/SupportTicketDetailsInputs.dart';

class AddSupportTicketInputs extends StatelessWidget {
  const AddSupportTicketInputs({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SupportSenderInputs(),
        const SizedBox(height: 32),
        Divider(
          height: 1,
          thickness: 1,
          color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.12),
        ),
        const SizedBox(height: 32),
        const SupportTicketDetailsInputs(),
      ],
    );
  }
}
