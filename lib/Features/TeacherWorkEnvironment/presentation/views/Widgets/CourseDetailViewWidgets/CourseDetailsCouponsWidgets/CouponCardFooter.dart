import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CouponItemUsage.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_expiry.dart';

class CouponCardFooter extends StatelessWidget {
  const CouponCardFooter({super.key, required this.coupon});
  final CourseCouponEntity coupon;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localCode = Localizations.localeOf(context).languageCode;
    final bool isRTL = localCode.toLowerCase() == "ar";

    final percent = coupon.usageLimit > 0
        ? (coupon.usedCount / coupon.usageLimit).clamp(0.0, 1.0)
        : 0.0;
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: CourseCouponGridViewItemExpiry(
                expirationDate: coupon.expiryDate,
                hasReachedLimit: coupon.hasReachedUsageLimit,
              ),
            ),
            const SizedBox(width: 8),
            CouponItemUsage(
              usedCount: coupon.usedCount,
              usageLimit: coupon.usageLimit,
              hasReachedLimit: coupon.hasReachedUsageLimit,
            ),
          ],
        ),
        SizedBox(height: 6),
        LayoutBuilder(
          builder: (context, constraints) {
            final progressColor = coupon.hasReachedUsageLimit
                ? theme.colorScheme.secondary
                : theme.colorScheme.primary;

            return SizedBox(
              width: constraints.maxWidth,
              child: LinearPercentIndicator(
                width: constraints.maxWidth,
                padding: EdgeInsets.zero,
                lineHeight: 8,
                percent: percent.clamp(0.0, 1.0),
                animation: true,
                animationDuration: 800,
                curve: Curves.easeOutCubic,
                isRTL: isRTL,
                barRadius: const Radius.circular(100),
                backgroundColor: theme.colorScheme.onSurface.withValues(
                  alpha: 0.07,
                ),
                progressColor: progressColor,
                addAutomaticKeepAlive: false,
              ),
            );
          },
        ),
      ],
    );
  }
}
