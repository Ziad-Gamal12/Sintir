import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/helper/ShowSnackBar.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/presentation/views/manager/CouponItemActionsCubit/coupon_item_actions_cubit.dart';

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
  bool _isUpdating = false;

  Future<void> _onChanged(bool enabled) async {
    final coupon = widget.couponEntity;
    if (_isUpdating || coupon.isExpired || coupon.hasReachedUsageLimit) {
      return;
    }

    setState(() {
      _isUpdating = true;
    });
    try {
      await context.read<CouponItemActionsCubit>().changeCouponStatus(
            couponID: widget.couponEntity.code,
            courseID: widget.courseID,
            status: enabled
                ? CourseCouponStatus.active
                : CourseCouponStatus.inactive,
          );
    } catch (error) {
      if (mounted) {
        CustomSnackBar.show(
          context,
          message: 'Failed to update coupon. Please try again.',
          type: SnackType.error,
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isUpdating = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final coupon = widget.couponEntity;

    final cannotBeActivated = coupon.isExpired || coupon.hasReachedUsageLimit;

    return SizedBox(
      width: 64,
      height: 48,
      child: Center(
        child: _isUpdating
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              )
            : Switch.adaptive(
                value: coupon.canBeUsed,
                onChanged: cannotBeActivated ? null : _onChanged,
                activeTrackColor: Color(0xff00843A),
                activeThumbColor: Colors.white,
                inactiveTrackColor: Colors.grey,
                inactiveThumbColor: Colors.white,
              ),
      ),
    );
  }
}
