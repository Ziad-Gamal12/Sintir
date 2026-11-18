import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/course_price_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/Custom%20Course%20Widgets/CourseCardMetrics.dart';
import 'package:sintir/locale_keys.dart';

class CheckoutPriceBreakdown extends StatelessWidget {
  const CheckoutPriceBreakdown({
    super.key,
    required this.originalCents,
    required this.discountCents,
    required this.totalCents,
  });

  final int originalCents;
  final int discountCents;
  final int totalCents;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final styles = AppTextStyles(context);
    final textColor = CourseCardMetrics.textColor(context);
    final muted = CourseCardMetrics.mutedColor(context);

    Widget row(String label, String value, {Color? valueColor}) => Row(
          children: [
            Expanded(
              child: Text(label, style: styles.regular14.copyWith(color: muted)),
            ),
            Text(
              value,
              style: styles.semiBold14.copyWith(color: valueColor ?? textColor),
            ),
          ],
        );

    return Container(
      key: const ValueKey('checkout-price-breakdown'),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: CourseCardMetrics.surfaceColor(context),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: CourseCardMetrics.borderColor(context)),
        boxShadow: CourseCardMetrics.shadow(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            LocaleKeys.paymentSummary,
            style: styles.bold16.copyWith(color: textColor),
          ),
          const SizedBox(height: 10),
          row(
            LocaleKeys.coursePrice,
            CoursePriceFormatter.fromCents(originalCents, locale),
          ),
          const SizedBox(height: 8),
          row(
            LocaleKeys.couponDiscountLine,
            CoursePriceFormatter.discountFromCents(discountCents, locale),
            valueColor: CourseCardMetrics.freeColor(context),
          ),
          Divider(height: 24, color: CourseCardMetrics.borderColor(context)),
          Row(
            children: [
              Expanded(
                child: Text(
                  LocaleKeys.checkoutTotal,
                  style: styles.bold16.copyWith(color: textColor),
                ),
              ),
              Text(
                CoursePriceFormatter.fromCents(totalCents, locale),
                style: styles.bold18.copyWith(color: textColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
