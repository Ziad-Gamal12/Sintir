import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/DiscountBadge.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/PriceCard.dart';
import 'package:sintir/locale_keys.dart';

class PremiumSubscriptionPriceSection extends StatelessWidget {
  final int originalPrice;
  final double discountPercent;
  final double payableAmount;

  const PremiumSubscriptionPriceSection({
    super.key,
    required this.originalPrice,
    required this.discountPercent,
    required this.payableAmount,
  });

  String _formatPrice(double amount) {
    final formatted = amount.toStringAsFixed(2);
    return formatted.replaceFirst(
      RegExp(r'\.?0+$'),
      '',
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool hasDiscount = discountPercent > 0;

    final String formattedPayableAmount = _formatPrice(payableAmount);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ORIGINAL PRICE
        PriceCard(
          icon: FontAwesomeIcons.tag,
          label: LocaleKeys.originalPrice,
          value: '$originalPrice ${LocaleKeys.priceEgp}',
          isOriginal: true,
          showStrike: hasDiscount,
        ),

        const SizedBox(height: 14),

        // DISCOUNT BADGE
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: hasDiscount
              ? DiscountBadge(
                  key: ValueKey(
                    'discount-$discountPercent',
                  ),
                  percent: discountPercent,
                )
              : const SizedBox.shrink(
                  key: ValueKey('no-discount'),
                ),
        ),

        const SizedBox(height: 14),

        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          transitionBuilder: (child, animation) {
            return FadeTransition(
              opacity: animation,
              child: ScaleTransition(
                scale: CurvedAnimation(
                  parent: animation,
                  curve: Curves.easeOutBack,
                ),
                child: child,
              ),
            );
          },
          child: PriceCard(
            key: ValueKey(
              'price-$hasDiscount-$formattedPayableAmount',
            ),
            icon: FontAwesomeIcons.moneyBillWave,
            label: LocaleKeys.discountedPrice,
            value: '$formattedPayableAmount ${LocaleKeys.priceEgp}',
            highlight: hasDiscount,
          ),
        ),
      ],
    );
  }
}
