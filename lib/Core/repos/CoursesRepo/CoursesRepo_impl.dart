import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';

class CoursesrepoImpl implements Coursesrepo {
  final Datebaseservice datebaseservice;
  final StorageService storageService;

  CoursesrepoImpl({
    required this.datebaseservice,
    required this.storageService,
  });
  @override
  Future<Either<Failure, void>> addCourse(
      {required CourseEntity courseEntity}) async {
    try {
      await datebaseservice.setData(
        key: BackendEndpoints.addCourseToCoursesCollection,
        docId: courseEntity.id,
        data: Coursemodel.fromEntity(courseEntity: courseEntity).toJson(),
      );
      await datebaseservice.setData(
          key: BackendEndpoints.addTeacherDataCollectionName,
          data: Coursemodel.fromEntity(courseEntity: courseEntity).toJson(),
          docId: courseEntity.contentcreaterentity!.id,
          subDocId: courseEntity.id,
          subCollectionKey: BackendEndpoints.addCourseToTeacherSubCollection);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from CoursesrepoImpl.addCourse in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, String>> uplaodFile({required File file}) async {
    try {
      String url = await storageService.uploadFile(file: file);
      return right(url);
    } on CustomException catch (e) {
      log("Exception from CoursesrepoImpl.uplaodFile in catch With firestorage Exception: ${e.toString()}");
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getRecentCourses() async {
    try {
      List data = await datebaseservice.getData(
        key: BackendEndpoints.getRecentCoursesCollection,
      );

      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } catch (e) {
      log("Exception from CoursesrepoImpl.getRecentCourses in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
