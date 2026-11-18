import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemCode extends StatelessWidget {
  const CourseCouponGridViewItemCode({super.key, required this.couponCode});
  final String couponCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        Clipboard.setData(ClipboardData(text: couponCode));
        CustomSnackBar.show(
          context,
          message: LocaleKeys.operationSuccessful,
          type: SnackType.success,
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: isDark ? Color(0xff353534) : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Text(
          couponCode,
          style: AppTextStyles(context).bold16.copyWith(
            color: isDark == false ? Colors.black : Colors.white,
          ),
        ),
      ),
    );
  }
}
