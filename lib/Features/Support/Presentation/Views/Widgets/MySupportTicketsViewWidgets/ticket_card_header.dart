// ticket_card_header.dart (Refined for Premium Feel)

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportTicketEntity.dart';
import 'package:sintir/Features/Support/Domain/Helper/support_card_helpers.dart';

class TicketCardHeader extends StatelessWidget {
  const TicketCardHeader({super.key, required this.ticket});

  final SupportTicketEntity ticket;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    final statusColor = getSupportCardStatusColor(context, ticket.status);
    final dateString = DateFormat('dd/MM/yyyy').format(ticket.createdAt);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: statusColor,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            ticket.status.toUpperCase(),
            style: textStyles.semiBold12.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                dateString,
                style: textStyles.regular14.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.6),
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '#${ticket.id.toUpperCase()}',
                style: textStyles.regular14.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
