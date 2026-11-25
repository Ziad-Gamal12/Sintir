import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/locale_formatter.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemDiscount extends StatelessWidget {
  const CourseCouponGridViewItemDiscount({
    super.key,
    required this.pecentage,
    this.discountColor = Colors.amber,
  });
  final double pecentage;
  final Color discountColor;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    final locale = Localizations.localeOf(context).languageCode;
    return Text.rich(
      TextSpan(
        text: "${LocaleFormatter.number(pecentage, locale)}%",
        children: [
          TextSpan(
            text: " ${LocaleKeys.couponDiscountOff}",
            style: AppTextStyles(context).medium12.copyWith(
              color: isDarkMode
                  ? Color(0xffC4C5D6)
                  : Color.fromARGB(255, 153, 153, 165),
            ),
          ),
        ],
        style: AppTextStyles(context).bold24.copyWith(color: discountColor),
      ),
    );
  }
}
