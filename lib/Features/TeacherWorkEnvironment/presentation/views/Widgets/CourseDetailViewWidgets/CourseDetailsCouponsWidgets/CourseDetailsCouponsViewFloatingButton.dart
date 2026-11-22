import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/AddCourseCouponWidgets/AddCourseCouponView.dart';
import 'package:sintir/constant.dart';

class CourseDetailsCouponsViewFloatingButton extends StatelessWidget {
  const CourseDetailsCouponsViewFloatingButton({
    super.key,
    required this.courseId,
  });

  final String courseId;

  Future<void> _openAddCoupon(BuildContext context) async {
    final cubit = context.read<CourseCouponsCubit>();
    // The add screen pops with the saved coupon, or null if it was left
    // without saving.
    final coupon = await GoRouter.of(
      context,
    ).push<CourseCouponEntity>(AddCourseCouponView.routeName, extra: courseId);
    if (coupon != null && !cubit.isClosed) {
      cubit.showAddedCoupon(coupon);
    }
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      key: const ValueKey('coupons-add-button'),
      backgroundColor: KMainColor,
      child: const Icon(Icons.add, color: Colors.white, size: 30),
      onPressed: () => _openAddCoupon(context),
    );
  }
}
