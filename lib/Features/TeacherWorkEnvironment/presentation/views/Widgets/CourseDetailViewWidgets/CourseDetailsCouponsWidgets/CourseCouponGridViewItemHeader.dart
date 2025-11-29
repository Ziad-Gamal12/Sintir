import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/utils/textStyles.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItemHeaderSwitcher.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_image.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponGridViewItemHeader extends StatelessWidget {
  const CourseCouponGridViewItemHeader({
    super.key,
    required this.couponEntity,
    required this.courseID,
  });

  final CourseCouponEntity couponEntity;
  final String courseID;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        const CourseCouponGridViewItemImage(),
        const SizedBox(width: 10),
        Text(LocaleKeys.coupon,
            style: AppTextStyles(context)
                .semiBold24
                .copyWith(color: Colors.black)),
        const Spacer(),
        CourseCouponGridViewItemHeaderSwitcher(
            courseID: courseID, couponEntity: couponEntity),
      ],
    );
  }
}
