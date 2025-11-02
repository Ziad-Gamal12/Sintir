import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItem.dart';
import 'package:sintir/constant.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseCouponsListViewLoading extends StatelessWidget {
  const CourseCouponsListViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: getFakeLoadingCoupons().length,
        padding: const EdgeInsets.symmetric(
            vertical: KVerticalPadding, horizontal: KHorizontalPadding),
        itemBuilder: (context, index) {
          return Skeletonizer(
              enabled: true,
              child: AspectRatio(
                aspectRatio: 2 / 1.4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                  ),
                  child: CourseCouponGridViewItem(
                      courseId: "",
                      couponEntity: getFakeLoadingCoupons()[index]),
                ),
              ));
        });
  }

  List<CourseCouponEntity> getFakeLoadingCoupons() =>
      List.generate(6, (index) => CourseCouponEntity.empty());
}
