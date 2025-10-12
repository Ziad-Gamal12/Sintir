part of 'course_coupons_cubit.dart';

@immutable
sealed class CourseCouponsState {}

final class CourseCouponsInitial extends CourseCouponsState {}

final class GetCourseCouponsLoading extends CourseCouponsState {}

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

final class DeleteCourseCouponLoading extends CourseCouponsState {}

final class DeleteCourseCouponSuccess extends CourseCouponsState {}

final class DeleteCourseCouponFailure extends CourseCouponsState {
  final String errmessage;
  DeleteCourseCouponFailure({required this.errmessage});
}

final class UpdateCourseCouponLoading extends CourseCouponsState {}

final class UpdateCourseCouponSuccess extends CourseCouponsState {}

final class UpdateCourseCouponFailure extends CourseCouponsState {
  final String errmessage;
  UpdateCourseCouponFailure({required this.errmessage});
}
