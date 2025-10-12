import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItemHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_info.dart';

class CourseCouponGridViewItem extends StatelessWidget {
  const CourseCouponGridViewItem({super.key, required this.couponEntity});
  final CourseCouponEntity couponEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade100,
            blurRadius: 10,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(color: Colors.grey.shade300, width: .5),
      ),
      child: Column(
        children: [
          CourseCouponGridViewItemHeader(couponEntity: couponEntity),
          Expanded(
              flex: 4,
              child: CourseCouponGridViewItemInfo(couponEntity: couponEntity)),
        ],
      ),
    );
  }
}
