// ticket_sender_footer.dart

import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCachedNetworkImage.dart';
import 'package:sintir/Features/Support/Domain/Entities/SupportSenderEntity.dart';

class TicketSenderFooter extends StatelessWidget {
  const TicketSenderFooter({super.key, required this.sender});

  final SupportSenderEntity sender;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final textStyles = AppTextStyles(context);
    const double avatarSize = 36.0; // Define a clean, fixed size for the avatar

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // 1. Profile Avatar
        Container(
          width: avatarSize,
          height: avatarSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: theme.dividerColor.withOpacity(0.5),
              width: 1.0,
            ),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(avatarSize),
            child: CustomCachedNetworkImage(
              imageUrl: sender.photoUrl,
            ),
          ),
        ),

        const SizedBox(width: 12),

        // 2. Sender Name (Strong Focus)
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                sender.name,
                style: textStyles.regular14.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),

        // 3. Sender Role (Muted/Secondary Info)
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: theme.primaryColor.withOpacity(0.05), // Subtle background
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(
            sender.role,
            style: textStyles.regular14.copyWith(
              color: theme.primaryColor.withOpacity(0.8),
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}
