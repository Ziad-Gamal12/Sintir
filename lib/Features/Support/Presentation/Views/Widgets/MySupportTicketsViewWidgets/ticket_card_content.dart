// ticket_card_content.dart (Minimalist & Premium Redesign)

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Presentation/Views/Widgets/MySupportTicketsViewWidgets/TicketSenderFooter.dart';

class TicketCardContent extends StatelessWidget {
  const TicketCardContent({super.key, required this.ticket});

  final SupportTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    const double verticalSpacer = 16.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title (Top priority, strong focus)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                ticket.title,
                style: textStyles.bold16.copyWith(
                  fontWeight: FontWeight.w800,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              ticket.category,
              style: textStyles.regular14.copyWith(
                color: theme.primaryColor,
                fontWeight: FontWeight.w700,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),

        const SizedBox(height: verticalSpacer),

        Text(
          ticket.description,
          style: textStyles.regular14.copyWith(
            color: theme.textTheme.bodyMedium?.color?.withOpacity(0.75),
            height: 1.4,
          ),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),

        const SizedBox(height: verticalSpacer),

        const Divider(height: 1, thickness: 0.5),
        const SizedBox(height: 12),

        TicketSenderFooter(sender: ticket.sender),
      ],
    );
  }
}
