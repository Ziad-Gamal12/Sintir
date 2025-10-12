import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';

class CourseCouponGridViewItemExpiry extends StatelessWidget {
  const CourseCouponGridViewItemExpiry({super.key, required this.couponEntity});
  final CourseCouponEntity couponEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "تنتهي في: ${couponEntity.expiryDate.day} / ${couponEntity.expiryDate.month} / ${couponEntity.expiryDate.year}",
          style: AppTextStyles(context).regular14.copyWith(color: Colors.black),
          overflow: TextOverflow.ellipsis,
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(
            FontAwesomeIcons.trash,
            color: Colors.red,
            size: 20,
          ),
        ),
      ],
    );
  }
}
