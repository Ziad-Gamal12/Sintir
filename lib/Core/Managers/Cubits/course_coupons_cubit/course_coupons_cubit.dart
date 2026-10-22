import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseCouponsResponseEntity.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';

part 'course_coupons_state.dart';

class CourseCouponsCubit extends Cubit<CourseCouponsState> {
  CourseCouponsCubit({required this.courseCouponsRepo})
      : super(CourseCouponsInitial());
  final CourseCouponsRepo courseCouponsRepo;

  Future<void> getCourseCoupons(
      {required String courseID, required bool isPaginate}) async {
    emit(GetCourseCouponsLoading(isPaginate: isPaginate));
    final result = await courseCouponsRepo.getCourseCoupons(
        courseID: courseID, isPaginate: isPaginate);
    result.fold(
        (failure) => emit(GetCourseCouponsFailure(errmessage: failure.message)),
        (response) => emit(GetCourseCouponsSuccess(response: response)));
  }

  Future<void> addCourseCoupon(
      {required String courseID, required CourseCouponEntity coupon}) async {
    emit(AddCourseCouponLoading());
    final result = await courseCouponsRepo.addCourseCoupon(
        courseID: courseID, coupon: coupon);
    result.fold(
        (failure) => emit(AddCourseCouponFailure(errmessage: failure.message)),
        (success) => emit(AddCourseCouponSuccess()));
  }

  Future<void> useCoupon(
      {required CourseCouponEntity coupon, required String courseID}) async {
    emit(UseCouponLoading());
    final result =
        await courseCouponsRepo.useCoupon(coupon: coupon, courseID: courseID);
    result.fold(
        (failure) => emit(UseCouponFailure(errmessage: failure.message)),
        (success) => emit(UseCouponSuccess()));
  }

  Future<void> isCouponExists(
      {required String couponCode, required String courseID}) async {
    emit(IsCouponExistLoading());
    final result = await courseCouponsRepo.isCouponExists(
        couponCode: couponCode, courseID: courseID);
    result.fold(
        (failure) => emit(IsCouponExistFailure(errmessage: failure.message)),
        (success) => emit(IsCouponExistSuccess(coupon: success)));
  }

  bool isCouponUsable(CourseCouponEntity coupon) {
    final hasReachedLimit =
        coupon.usageLimit > 0 && coupon.usedCount >= coupon.usageLimit;

    return coupon.status == CourseCouponStatus.active &&
        !coupon.isExpired &&
        !hasReachedLimit;
  }
}
