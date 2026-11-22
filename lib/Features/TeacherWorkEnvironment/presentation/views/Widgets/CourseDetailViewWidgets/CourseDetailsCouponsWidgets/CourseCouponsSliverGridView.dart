import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItem.dart';

class CourseCouponsSliverGridView extends StatelessWidget {
  const CourseCouponsSliverGridView({
    super.key,
    required this.coupons,
    required this.courseId,
  });

  final List<CourseCouponEntity> coupons;
  final String courseId;

  @override
  Widget build(BuildContext context) {
    return SliverGrid.builder(
      itemCount: coupons.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 480.0,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        mainAxisExtent: 240.0,
      ),
      itemBuilder: (context, index) {
        return CourseCouponGridViewItem(
          key: ValueKey('coupon-${coupons[index].code}'),
          couponEntity: coupons[index],
          courseId: courseId,
        );
      },
    );
  }
}
