import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_code.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_discount.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_expiry.dart';

class CourseCouponGridViewItemInfo extends StatelessWidget {
  const CourseCouponGridViewItemInfo({super.key, required this.couponEntity});
  final CourseCouponEntity couponEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CourseCouponGridViewItemDiscount(couponEntity: couponEntity),
        const SizedBox(height: 10),
        CourseCouponGridViewItemCode(couponEntity: couponEntity),
        const Spacer(),
        CourseCouponGridViewItemExpiry(couponEntity: couponEntity),
      ],
    );
  }
}
