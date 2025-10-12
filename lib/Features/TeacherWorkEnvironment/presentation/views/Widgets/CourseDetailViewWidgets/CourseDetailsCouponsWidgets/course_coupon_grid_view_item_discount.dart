import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseCouponGridViewItemDiscount extends StatelessWidget {
  const CourseCouponGridViewItemDiscount(
      {super.key, required this.couponEntity});
  final CourseCouponEntity couponEntity;

  @override
  Widget build(BuildContext context) {
    return Text(
      "${couponEntity.discountPercentage}%",
      style: AppTextStyles(context).bold48.copyWith(color: Colors.amber),
    );
  }
}
