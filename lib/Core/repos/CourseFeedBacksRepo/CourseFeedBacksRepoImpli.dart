import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseFeedBacksRepo/CourseFeedBacksRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
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
      Map<String, dynamic> json =
          Coursefeedbacksmodel.fromEntity(coursefedbackItemEntity: review)
              .toJson();
      await databaseservice.setData(
          data: json,
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.coursesCollection,
              docId: courseId,
              subCollection: BackendEndpoints.feedBacksSubCollection));
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CoursefeedbackItemEntity>>> getCourseFedBacks(
      {required String courseId}) async {
    try {
      List reviews = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.coursesCollection,
              docId: courseId,
              subCollection: BackendEndpoints.feedBacksSubCollection));
      List<CoursefeedbackItemEntity> courseReviews = reviews
          .map((e) => Coursefeedbacksmodel.fromJson(e).toEntity())
          .toList();
      return right(courseReviews);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
