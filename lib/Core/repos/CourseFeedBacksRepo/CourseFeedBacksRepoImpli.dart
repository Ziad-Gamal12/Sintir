import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseFedBacksModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursefedbackItemEntity.dart';

class CourseFeedBacksRepoImpli implements CourseFeedBacksRepo {
  final Databaseservice databaseservice;

  CourseFeedBacksRepoImpli({required this.databaseservice});
  @override
  Future<Either<Failure, void>> addCourseFedBack(
      {required String courseId,
      required CoursefeedbackItemEntity review}) async {
    try {
      if (isStudent() == false) {
        Map<String, dynamic> json =
            Coursefeedbacksmodel.fromEntity(coursefedbackItemEntity: review)
                .toJson();
        await databaseservice.setData(
            data: json,
            requirements: FireStoreRequirmentsEntity(
                collection: BackendEndpoints.coursesCollection,
                docId: courseId,
                subCollection: BackendEndpoints.feedBacksSubCollection,
                subDocId: review.uid));
        return right(null);
      } else {
        return left(
            ServerFailure(message: "غير متاح لغير الطلاب بأضافة تقييم"));
      }
    } on CustomException catch (e) {
      log(e.message);
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log(e.toString());
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CoursefeedbackItemEntity>>> getCourseFedBacks(
      {required String courseId}) async {
    try {
      FireStoreResponse response = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.coursesCollection,
              docId: courseId,
              subCollection: BackendEndpoints.feedBacksSubCollection));
      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right([]);
      }
      List<CoursefeedbackItemEntity> courseReviews = response.listData!
          .map((e) => Coursefeedbacksmodel.fromJson(e).toEntity())
          .toList();
      return right(courseReviews);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  bool isStudent() {
    String role = shared_preferences_Services.stringGetter(
        key: BackendEndpoints.userKind);
    if (role == "student") {
      return true;
    } else {
      return false;
    }
  }
}
