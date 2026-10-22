import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/Enums/CourseCouponEnum.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';

part 'coupon_item_actions_state.dart';

class CouponItemActionsCubit extends Cubit<CouponItemActionsState> {
  CouponItemActionsCubit({required this.couponsRepo})
      : super(CouponItemActionsInitial());
  final CourseCouponsRepo couponsRepo;
  Future<void> changeCouponStatus(
      {required String courseID,
      required String couponID,
      required CourseCouponStatus status}) async {
    emit(UpdateCouponItemStatusLoading(couponID: couponID));
    final changeStatusResult = await couponsRepo.changeCouponStatus(
        courseID: courseID, couponID: couponID, status: status);
    changeStatusResult.fold((failure) {
      emit(UpdateCouponItemStatusFailure(errMessage: failure.message));
    }, (success) {
      emit(
          UpdateCouponItemStatusSuccess(newStatus: status, couponID: couponID));
    });
  }

  Future<void> updateCourseCoupon(
      {required String courseID, required CourseCouponEntity coupon}) async {
    emit(UpdateCourseCouponLoading());
    final result = await couponsRepo.updateCourseCoupon(
        courseID: courseID, coupon: coupon);
    result.fold(
        (failure) =>
            emit(UpdateCourseCouponFailure(errmessage: failure.message)),
        (success) => emit(UpdateCourseCouponSuccess()));
  }

  Future<void> deleteCourseCoupon(
      {required String courseID, required String couponID}) async {
    emit(DeleteCourseCouponLoading(couponId: couponID));
    final result = await couponsRepo.deleteCourseCoupon(
        courseID: courseID, couponID: couponID);
    result.fold(
        (failure) =>
            emit(DeleteCourseCouponFailure(errmessage: failure.message)),
        (success) => emit(DeleteCourseCouponSuccess(
              couponId: couponID,
            )));
  }
}
