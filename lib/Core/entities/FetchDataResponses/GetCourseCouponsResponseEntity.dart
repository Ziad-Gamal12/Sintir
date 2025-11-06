import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';

class GetCourseCouponsResponseEntity {
  final List<CourseCouponEntity> coupons;
  final bool hasMore;
  final bool isPaginate;

  GetCourseCouponsResponseEntity(
      {required this.coupons, required this.hasMore, required this.isPaginate});
}
