import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseCouponEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetCourseCouponsResponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseCouponModel.dart';
import 'package:sintir/Core/repos/CourseCouponsRepo/CourseCouponsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/locale_keys.dart';

class CourseCouponsRepoImp implements CourseCouponsRepo {
  final DataBaseService databaseservice;
  CourseCouponsRepoImp({required this.databaseservice});

  DocumentSnapshot? _lastDoc;

  final Map<String, dynamic> _baseQuery = {
    "startAfter": null,
    "orderBy": "expiryDate",
    "limit": 10,
  };

  @override
  Future<Either<Failure, void>> addCourseCoupon({
    required String courseID,
    required CourseCouponEntity coupon,
  }) async {
    try {
      final json = CourseCouponModel.fromEntity(coupon).toJson();

      await databaseservice.setData(
        data: json,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseID,
          subCollection: BackendEndpoints.couponsSubCollection,
          subDocId: coupon.code,
        ),
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      return left(ServerFailure(message: LocaleKeys.couponAddError));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCourseCoupon({
    required String courseID,
    required String couponID,
  }) async {
    try {
      await databaseservice.deleteDoc(
        collectionKey: BackendEndpoints.coursesCollection,
        docId: courseID,
        subCollectionKey: BackendEndpoints.couponsSubCollection,
        subDocId: couponID,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.couponDeleteError));
    }
  }

  @override
  Future<Either<Failure, void>> updateCourseCoupon({
    required String courseID,
    required CourseCouponEntity coupon,
  }) async {
    try {
      final json = CourseCouponModel.fromEntity(coupon).toJson();

      await databaseservice.setData(
        data: json,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseID,
          subCollection: BackendEndpoints.couponsSubCollection,
          subDocId: coupon.code,
        ),
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.couponUpdateError));
    }
  }

  @override
  Future<Either<Failure, GetCourseCouponsResponseEntity>> getCourseCoupons({
    required String courseID,
    required bool isPaginate,
  }) async {
    try {
      _baseQuery["startAfter"] = isPaginate ? _lastDoc : null;

      final response = await databaseservice.getData(
        query: _baseQuery,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseID,
          subCollection: BackendEndpoints.couponsSubCollection,
        ),
      );

      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }

      if (response.listData!.isEmpty) {
        return right(
          GetCourseCouponsResponseEntity(
            coupons: [],
            hasMore: false,
            isPaginate: isPaginate,
          ),
        );
      }

      if (response.lastDocumentSnapshot != null) {
        _lastDoc = response.lastDocumentSnapshot;
      }

      final coupons = await compute(
        _mapCoupons,
        response.listData as List<Map<String, dynamic>>,
      );

      final hasMore = response.hasMore ?? false;

      return right(
        GetCourseCouponsResponseEntity(
          coupons: coupons,
          hasMore: hasMore,
          isPaginate: isPaginate,
        ),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.fetchCouponsError));
    }
  }

  @override
  Future<Either<Failure, CourseCouponEntity>> isCouponExists(
      {required String couponCode, required String courseID}) async {
    try {
      final response = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseID,
          subCollection: BackendEndpoints.couponsSubCollection,
          subDocId: couponCode,
        ),
      );
      if (response.docData != null) {
        return right(CourseCouponModel.fromJson(response.docData!).toEntity());
      } else {
        return left(ServerFailure(message: LocaleKeys.couponNotFound));
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, void>> useCoupon(
      {required CourseCouponEntity coupon, required String courseID}) async {
    try {
      coupon.usageLimit -= 1;
      coupon.usedCount += 1;
      return updateCourseCoupon(courseID: courseID, coupon: coupon);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

List<CourseCouponEntity> _mapCoupons(List<Map<String, dynamic>> data) {
  return data.map((e) => CourseCouponModel.fromJson(e).toEntity()).toList();
}
