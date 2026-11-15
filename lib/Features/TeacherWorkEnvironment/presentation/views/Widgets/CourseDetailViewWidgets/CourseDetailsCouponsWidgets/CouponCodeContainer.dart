import 'package:flutter/material.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Core/widgets/CustomCopyToClipboard.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_code.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_image.dart';

class CouponCodeContainer extends StatelessWidget {
  const CouponCodeContainer({super.key, required this.couponCode});
  final String couponCode;
  @override
  Widget build(BuildContext context) {
    final appTextStyles = AppTextStyles(context);
    final theme = Theme.of(context);
    final isDarkMode = theme.brightness == Brightness.dark;
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDarkMode ? Colors.grey[900] : Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CourseCouponGridViewItemImage(),
                const SizedBox(width: 8),
                Text(
                  'الكود:',
                  style: appTextStyles.medium12.copyWith(
                    color: isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: CourseCouponGridViewItemCode(couponCode: couponCode),
                ),
              ],
            ),
          ),
          SizedBox(width: 8),
          CustomCopyToClipboard(value: couponCode),
        ],
      ),
    );
  }
}
