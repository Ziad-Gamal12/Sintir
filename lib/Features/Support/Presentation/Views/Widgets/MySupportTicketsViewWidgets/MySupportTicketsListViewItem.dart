// my_support_ticket_list_item.dart (Refined Premium Card Shell)

import 'package:flutter/material.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Domain/Helper/support_card_helpers.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/ticket_card_content.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/ticket_card_header.dart';

class MySupportTicketsListViewItem extends StatelessWidget {
  const MySupportTicketsListViewItem(
      {super.key, required this.supportTicketEntity});

  final SupportTicketEntity supportTicketEntity;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor =
        getSupportCardStatusColor(context, supportTicketEntity.status);
    const double borderRadiusValue = 18.0; // Consistent, generous radius

    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: 16.0, vertical: 10.0), // Increased vertical space
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(borderRadiusValue),
          // Premium, diffused shadow
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.08),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),

        // --- Integration of the Accent Line with Padding ---
        child: Column(
          children: [
            Container(
              height: 4.0,
              decoration: BoxDecoration(
                color: statusColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(borderRadiusValue),
                  topRight: Radius.circular(borderRadiusValue),
                ),
              ),
            ),

            // Card Content Area
            Padding(
              padding: const EdgeInsets.all(20.0), // Generous padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TicketCardHeader(ticket: supportTicketEntity),
                  const SizedBox(height: 12),
                  TicketCardContent(ticket: supportTicketEntity),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
