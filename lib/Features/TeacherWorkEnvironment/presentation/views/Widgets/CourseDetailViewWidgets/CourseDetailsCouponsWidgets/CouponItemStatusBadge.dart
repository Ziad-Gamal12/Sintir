import 'package:flutter/material.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CouponItemStatusBadge extends StatelessWidget {
  const CouponItemStatusBadge({super.key, required this.availability});
  final CourseCouponAvailability availability;
  @override
  Widget build(BuildContext context) {
    final AppTextStyles textStyles = AppTextStyles(context);
    return IntrinsicWidth(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        decoration: BoxDecoration(
          color: availability.color.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(
              availability.badgeIcon.icon,
              color: availability.badgeIcon.color,
              size: 12,
            ),
            SizedBox(width: 4),
            Text(availability.label,
                style: textStyles.medium12.copyWith(color: availability.color)),
          ],
        ),
      ),
    );
  }
}
