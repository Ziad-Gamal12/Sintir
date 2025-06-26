import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseReportsRepo/CourseReportsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursereportsitemModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseReportsItemEntity.dart';

class CourseReportsRepoimpli implements CourseReportsRepo {
  final Databaseservice databaseservice;

  CourseReportsRepoimpli({required this.databaseservice});
  @override
  Future<Either<Failure, void>> addCourseReport(
      {required String courseId,
      required Coursereportsitementity reportEntity}) async {
    try {
      Map<String, dynamic> json = CoursereportsitemModel.fromEntity(
              courseReportsItemEntity: reportEntity)
          .toJson();
      await databaseservice.setData(
          data: json,
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.reportsSubCollection,
          ));
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<Coursereportsitementity>>> getCourseReports(
      {required String courseId}) async {
    try {
      List reports = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollection: BackendEndpoints.reportsSubCollection,
      ));
      List<Coursereportsitementity> courseReports = reports
          .map((e) => CoursereportsitemModel.fromJson(e).toEntity())
          .toList();
      return right(courseReports);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
