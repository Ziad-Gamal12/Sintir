part of 'coupon_item_actions_cubit.dart';

@immutable
sealed class CouponItemActionsState {}

final class CouponItemActionsInitial extends CouponItemActionsState {}

final class UpdateCouponItemStatusLoading extends CouponItemActionsState {
  final String couponID;

  UpdateCouponItemStatusLoading({required this.couponID});
}

final class UpdateCouponItemStatusSuccess extends CouponItemActionsState {
  final CourseCouponStatus newStatus;
  final String couponID;

  UpdateCouponItemStatusSuccess({
    required this.newStatus,
    required this.couponID,
  });
}

final class UpdateCouponItemStatusFailure extends CouponItemActionsState {
  final String errMessage;

  UpdateCouponItemStatusFailure({required this.errMessage});
}

final class UpdateCourseCouponLoading extends CouponItemActionsState {}

final class UpdateCourseCouponSuccess extends CouponItemActionsState {}

final class UpdateCourseCouponFailure extends CouponItemActionsState {
  final String errmessage;
  UpdateCourseCouponFailure({required this.errmessage});
}

final class DeleteCourseCouponLoading extends CouponItemActionsState {
  final String couponId;

  DeleteCourseCouponLoading({required this.couponId});
}

final class DeleteCourseCouponSuccess extends CouponItemActionsState {
  final String couponId;
  DeleteCourseCouponSuccess({required this.couponId});
}

final class DeleteCourseCouponFailure extends CouponItemActionsState {
  final String errmessage;
  DeleteCourseCouponFailure({required this.errmessage});
}
