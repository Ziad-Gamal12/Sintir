import 'package:flutter/material.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/widgets/CustomEmptyWidget.dart';
import 'package:sintir/Core/widgets/CustomErrorWidget.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponsGridViewLoading.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponsSliverGridView.dart';

class CourseDetailsCouponsViewContent extends StatelessWidget {
  const CourseDetailsCouponsViewContent({
    super.key,
    required this.courseId,
    required this.coupons,
    required this.hasMore,
    required this.scrollController,
    required this.state,
  });

  final String courseId;
  final List<CourseCouponEntity> coupons;
  final bool hasMore;
  final ScrollController scrollController;
  final CourseCouponsState state;

  @override
  Widget build(BuildContext context) {
    if (coupons.isEmpty) {
      if (state is GetCourseCouponsFailure) {
        return Center(
          child: CustomErrorWidget(
            errormessage: (state as GetCourseCouponsFailure).errmessage,
          ),
        );
      }

      if (state is CourseCouponsInitial || state is GetCourseCouponsLoading) {
        return const CourseCouponsGridViewLoading();
      }

      if (!hasMore) {
        return CustomEmptyWidget();
      }
    }

    return CustomScrollView(
      controller: scrollController,
      slivers: [
        if (coupons.isNotEmpty)
          CourseCouponsSliverGridView(
            courseId: courseId,
            coupons: coupons,
          )
        else
          SliverFillRemaining(
            hasScrollBody: false,
            child: Center(
              child: SizedBox(
                width: 28,
                height: 28,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
          ),
        if (state is GetCourseCouponsLoading &&
            (state as GetCourseCouponsLoading).isPaginate)
          const SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 24),
              child: Center(
                child: SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
