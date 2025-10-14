// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/GetCourseCouponsResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';

abstract class CourseCouponsRepo {
  Future<Either<Failure, GetCourseCouponsResponseEntity>> getCourseCoupons({
    required String courseID,
    required bool isPaginate,
  });
  Future<Either<Failure, void>> addCourseCoupon({
    required String courseID,
    required CourseCouponEntity coupon,
  });
  Future<Either<Failure, void>> deleteCourseCoupon({
    required String courseID,
    required String couponID,
  });
  Future<Either<Failure, void>> updateCourseCoupon({
    required String courseID,
    required CourseCouponEntity coupon,
  });
  Future<Either<Failure,CourseCouponEntity >> isCouponExists({
    required String couponCode,
    required String courseID,
  });
  Future<Either<Failure, void>> useCoupon({
    required CourseCouponEntity coupon,
    required String courseID,
  });
}
