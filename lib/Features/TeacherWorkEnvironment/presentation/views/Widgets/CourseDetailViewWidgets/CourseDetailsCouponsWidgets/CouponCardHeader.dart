import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CouponItemStatusBadge.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CouponPopupMenuButton.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/CourseCouponGridViewItemHeaderSwitcher.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/Widgets/CourseDetailViewWidgets/CourseDetailsCouponsWidgets/course_coupon_grid_view_item_discount.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/coupon_item_actions_cubit/coupon_item_actions_cubit.dart';

class CouponCardHeader extends StatelessWidget {
  const CouponCardHeader({
    super.key,
    required this.couponEntity,
    required this.courseID,
  });

  final CourseCouponEntity couponEntity;
  final String courseID;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CouponItemActionsCubit, CouponItemActionsState>(
      listener: (context, state) {
        if (state is UpdateCouponItemStatusSuccess &&
            state.couponID == couponEntity.code) {
          couponEntity.status = state.newStatus;
        } else if (state is UpdateCouponItemStatusFailure) {
          CustomSnackBar.show(
            context,
            message: state.errMessage,
            type: SnackType.error,
          );
        }
      },
      builder: (context, state) {
        return Row(
          children: [
            Expanded(
              child: Wrap(
                children: [
                  CourseCouponGridViewItemDiscount(
                    pecentage: couponEntity.discountPercentage,
                    discountColor:
                        couponEntity.availability ==
                            CourseCouponAvailability.active
                        ? Colors.amber.shade600
                        : Colors.grey,
                  ),
                  SizedBox(width: 8),
                  CouponItemStatusBadge(
                    availability: couponEntity.availability,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            CourseCouponGridViewItemHeaderSwitcher(
              courseID: courseID,
              couponEntity: couponEntity,
            ),
            SizedBox(width: 4),
            CouponPopupMenuButton(
              couponID: couponEntity.code,
              courseID: courseID,
            ),
          ],
        );
      },
    );
  }
}
