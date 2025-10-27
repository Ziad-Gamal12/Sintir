import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItem.dart';
import 'package:sintir/constant.dart';

class CourseCouponsListView extends StatelessWidget {
  const CourseCouponsListView(
      {super.key,
      required this.coupons,
      required this.scrollController,
      required this.courseId});
  final List<CourseCouponEntity> coupons;
  final ScrollController scrollController;
  final String courseId;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        controller: scrollController,
        itemCount: coupons.length,
        padding: const EdgeInsets.symmetric(
            vertical: KVerticalPadding, horizontal: KHorizontalPadding),
        itemBuilder: (context, index) {
          return AspectRatio(
            aspectRatio: 2 / 1.4,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10,
              ),
              child: CourseCouponGridViewItem(
                  couponEntity: coupons[index], courseId: courseId),
            ),
          );
        });
  }
}
