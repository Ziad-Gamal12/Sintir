import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/GetCourseCouponsResponseEntity.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';

part 'course_coupons_state.dart';

class CourseCouponsCubit extends Cubit<CourseCouponsState> {
  CourseCouponsCubit({required this.courseCouponsRepo})
      : super(CourseCouponsInitial());
  final CourseCouponsRepo courseCouponsRepo;

  Future<void> getCourseCoupons(
      {required String courseID, required bool isPaginate}) async {
    emit(GetCourseCouponsLoading());
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

  Future<void> deleteCourseCoupon(
      {required String courseID, required String couponID}) async {
    emit(DeleteCourseCouponLoading());
    final result = await courseCouponsRepo.deleteCourseCoupon(
        courseID: courseID, couponID: couponID);
    result.fold(
        (failure) =>
            emit(DeleteCourseCouponFailure(errmessage: failure.message)),
        (success) => emit(DeleteCourseCouponSuccess()));
  }

  Future<void> updateCourseCoupon(
      {required String courseID, required CourseCouponEntity coupon}) async {
    emit(UpdateCourseCouponLoading());
    final result = await courseCouponsRepo.updateCourseCoupon(
        courseID: courseID, coupon: coupon);
    result.fold(
        (failure) =>
            emit(UpdateCourseCouponFailure(errmessage: failure.message)),
        (success) => emit(UpdateCourseCouponSuccess()));
  }
}
