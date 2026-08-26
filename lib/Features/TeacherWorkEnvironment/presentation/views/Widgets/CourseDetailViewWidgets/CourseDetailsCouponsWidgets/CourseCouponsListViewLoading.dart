import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItem.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseCouponsGridViewLoading extends StatelessWidget {
  const CourseCouponsGridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: getFakeLoadingCoupons().length,
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 320,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: 1.35),
        padding: const EdgeInsets.symmetric(
            vertical: KVerticalPadding, horizontal: KHorizontalPadding),
        itemBuilder: (context, index) {
          return Skeletonizer(
            enabled: true,
            child: CourseCouponGridViewItem(
                courseId: "", couponEntity: getFakeLoadingCoupons()[index]),
          );
        });
  }

  List<CourseCouponEntity> getFakeLoadingCoupons() =>
      List.generate(6, (index) => CourseCouponEntity.empty());
}
