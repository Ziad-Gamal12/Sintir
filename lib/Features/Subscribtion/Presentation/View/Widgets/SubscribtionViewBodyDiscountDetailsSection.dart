import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/DiscountBadge.dart';
import 'package:sintir/Features/Subscribtion/Presentation/View/Widgets/PriceCard.dart';

class PremiumSubscriptionPriceSection extends StatelessWidget {
  final int originalPrice;

  const PremiumSubscriptionPriceSection({
    super.key,
    required this.originalPrice,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCouponsCubit, CourseCouponsState>(
      builder: (context, state) {
        final bool hasDiscount = state is IsCouponExistSuccess &&
            state.coupon.isActive &&
            !state.coupon.isExpired;

        final double discountPercent =
            hasDiscount ? state.coupon.discountPercentage : 0;

        final int discountedPrice = hasDiscount
            ? state.coupon.applyDiscount(originalPrice).toInt()
            : originalPrice;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ORIGINAL PRICE
            PriceCard(
              icon: FontAwesomeIcons.tag,
              label: "السعر الأصلي",
              value: "$originalPrice جنيه",
              isOriginal: true,
              showStrike: hasDiscount,
            ),

            const SizedBox(height: 14),

            // DISCOUNT BADGE
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 500),
              child: hasDiscount
                  ? DiscountBadge(percent: discountPercent)
                  : const SizedBox.shrink(),
            ),

            const SizedBox(height: 14),

            // DISCOUNTED PRICE
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 600),
              transitionBuilder: (child, anim) => FadeTransition(
                opacity: anim,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: anim,
                    curve: Curves.easeOutBack,
                  ),
                  child: child,
                ),
              ),
              child: PriceCard(
                key: ValueKey(discountedPrice),
                icon: FontAwesomeIcons.moneyBillWave,
                label: "السعر بعد الخصم",
                value: "$discountedPrice جنيه",
                highlight: hasDiscount,
              ),
            ),
          ],
        );
      },
    );
  }
}
