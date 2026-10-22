import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CouponCardFooter.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CouponCardHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CouponCodeContainer.dart';

class CourseCouponGridViewItem extends StatelessWidget {
  const CourseCouponGridViewItem(
      {super.key, required this.couponEntity, required this.courseId});
  final CourseCouponEntity couponEntity;

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;
    final Color cardColor = isDarkMode ? Color(0xff1C1B1B) : Color(0xffF9F9F9);

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          CouponCardHeader(courseID: courseId, couponEntity: couponEntity),
          SizedBox(
            height: 12,
          ),
          CouponCodeContainer(
            couponCode: couponEntity.code,
          ),
          SizedBox(
            height: 12,
          ),
          CouponCardFooter(
            coupon: couponEntity,
          )
        ],
      ),
    );
  }
}
