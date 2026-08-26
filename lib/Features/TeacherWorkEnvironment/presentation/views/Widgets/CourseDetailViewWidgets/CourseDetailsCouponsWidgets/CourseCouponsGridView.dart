import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItem.dart';
import 'package:sintir/constant.dart';

class CourseCouponsGridView extends StatelessWidget {
  const CourseCouponsGridView(
      {super.key,
      required this.coupons,
      required this.scrollController,
      required this.courseId});
  final List<CourseCouponEntity> coupons;
  final ScrollController scrollController;
  final String courseId;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        controller: scrollController,
        itemCount: coupons.length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 320,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 1.35,
        ),
        padding: const EdgeInsets.symmetric(
            vertical: KVerticalPadding, horizontal: KHorizontalPadding),
        itemBuilder: (context, index) {
          return CourseCouponGridViewItem(
              couponEntity: coupons[index], courseId: courseId);
        });
  }
}
