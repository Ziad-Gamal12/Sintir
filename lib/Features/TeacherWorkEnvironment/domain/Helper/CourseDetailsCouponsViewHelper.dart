import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';

class CourseDetailsCouponsViewHelper {
  CourseDetailsCouponsViewHelper._();

  static const double paginationThreshold = 200;

  static bool shouldRequestNextPage({
    required bool hasMore,
    required bool isLoading,
    required bool hasScrollClients,
    required double? extentAfter,
    bool allowWithoutScroll = false,
  }) {
    if (!hasMore || isLoading) return false;

    if (!hasScrollClients || extentAfter == null) {
      return allowWithoutScroll;
    }

    return extentAfter <= paginationThreshold;
  }

  static List<CourseCouponEntity> mergeUniqueCoupons({
    required Iterable<CourseCouponEntity> existing,
    required Iterable<CourseCouponEntity> incoming,
  }) {
    final mergedCoupons = List<CourseCouponEntity>.of(existing);

    final existingCodes = mergedCoupons
        .map((coupon) => coupon.code)
        .toSet();

    for (final coupon in incoming) {
      if (existingCodes.add(coupon.code)) {
        mergedCoupons.add(coupon);
      }
    }

    return mergedCoupons;
  }

  static List<CourseCouponEntity> removeCouponByCode({
    required Iterable<CourseCouponEntity> coupons,
    required String code,
  }) {
    return coupons
        .where((coupon) => coupon.code != code)
        .toList();
  }
}