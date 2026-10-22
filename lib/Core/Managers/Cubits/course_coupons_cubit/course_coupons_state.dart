part of 'course_coupons_cubit.dart';

@immutable
sealed class CourseCouponsState {}

final class CourseCouponsInitial extends CourseCouponsState {}

final class GetCourseCouponsLoading extends CourseCouponsState {
  final bool isPaginate;

  GetCourseCouponsLoading({required this.isPaginate});
}

final class GetCourseCouponsSuccess extends CourseCouponsState {
  final GetCourseCouponsResponseEntity response;
  GetCourseCouponsSuccess({required this.response});
}

final class GetCourseCouponsFailure extends CourseCouponsState {
  final String errmessage;
  GetCourseCouponsFailure({required this.errmessage});
}

final class AddCourseCouponLoading extends CourseCouponsState {}

final class AddCourseCouponSuccess extends CourseCouponsState {}

final class AddCourseCouponFailure extends CourseCouponsState {
  final String errmessage;
  AddCourseCouponFailure({required this.errmessage});
}

//is CouponExist
final class IsCouponExistLoading extends CourseCouponsState {}

final class IsCouponExistSuccess extends CourseCouponsState {
  final CourseCouponEntity coupon;
  IsCouponExistSuccess({required this.coupon});
}

final class IsCouponExistFailure extends CourseCouponsState {
  final String errmessage;
  IsCouponExistFailure({required this.errmessage});
}
// use Coupon

final class UseCouponLoading extends CourseCouponsState {}

final class UseCouponSuccess extends CourseCouponsState {}

final class UseCouponFailure extends CourseCouponsState {
  final String errmessage;
  UseCouponFailure({required this.errmessage});
}
