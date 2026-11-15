import 'package:flutter/material.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItem.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CourseCouponsGridViewLoading extends StatelessWidget {
  const CourseCouponsGridViewLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: CourseCouponEntity.loadingItems().length,
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 480.0,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          mainAxisExtent: 240.0,
        ),
        itemBuilder: (context, index) {
          return CourseCouponGridViewItem(
            courseId: "",
            couponEntity: CourseCouponEntity.loadingItems()[index],
          );
        },
      ),
    );
  }
}
