import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Managers/Cubits/course_coupons_cubit/course_coupons_cubit.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';

class CourseCouponGridViewItemHeaderSwitcher extends StatefulWidget {
  const CourseCouponGridViewItemHeaderSwitcher({
    super.key,
    required this.couponEntity,
    required this.courseID,
  });

  final CourseCouponEntity couponEntity;
  final String courseID;

  @override
  State<CourseCouponGridViewItemHeaderSwitcher> createState() =>
      _CourseCouponGridViewItemHeaderSwitcherState();
}

class _CourseCouponGridViewItemHeaderSwitcherState
    extends State<CourseCouponGridViewItemHeaderSwitcher> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<CourseCouponsCubit, CourseCouponsState>(
      listener: (context, state) {
        if (state is UpdateCourseCouponSuccess) {
          CustomSnackBar.show(
            context,
            message: "تم تعديل الكوبون بنجاح",
            type: SnackType.success,
          );
        } else if (state is UpdateCourseCouponFailure) {
          CustomSnackBar.show(
            context,
            message: state.errmessage,
            type: SnackType.error,
          );
        }
      },
      child: SizedBox(
        width: 100,
        height: 40,
        child: Switch(
          activeTrackColor: Colors.grey[450],
          activeThumbColor: Colors.green,
          inactiveTrackColor: Colors.grey.shade100,
          inactiveThumbColor: Colors.grey.shade500,
          value: widget.couponEntity.isActive,
          onChanged: (val) async {
            setState(() {
              widget.couponEntity.isActive = val;
            });
            widget.couponEntity.isActive = val;
            await context.read<CourseCouponsCubit>().updateCourseCoupon(
                  coupon: widget.couponEntity,
                  courseID: widget.courseID,
                );
          },
        ),
      ),
    );
  }
}
