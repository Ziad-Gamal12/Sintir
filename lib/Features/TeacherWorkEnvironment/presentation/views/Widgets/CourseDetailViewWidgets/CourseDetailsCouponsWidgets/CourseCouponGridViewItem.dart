import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItemHeader.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_info.dart';

class CourseCouponGridViewItem extends StatelessWidget {
  const CourseCouponGridViewItem(
      {super.key, required this.couponEntity, required this.courseId});
  final CourseCouponEntity couponEntity;

  final String courseId;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final Color cardColor = theme.cardColor;
    final Color borderColor = theme.dividerColor;
    final bool isDarkMode = theme.brightness == Brightness.dark;

    // Adjusted shadow for theme compatibility
    final List<BoxShadow> boxShadows = isDarkMode
        ? [
            BoxShadow(
              color: Colors.grey.withOpacity(0.4),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ]
        : [
            BoxShadow(
              color: Colors.grey.shade100,
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 3),
            ),
          ];

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: boxShadows,
        border: Border.all(color: borderColor.withOpacity(0.5), width: .5),
      ),
      child: Column(
        children: [
          CourseCouponGridViewItemHeader(
              courseID: courseId, couponEntity: couponEntity),
          Expanded(
              flex: 4,
              child: CourseCouponGridViewItemInfo(
                couponEntity: couponEntity,
                courseId: courseId,
              )),
        ],
      ),
    );
  }
}
