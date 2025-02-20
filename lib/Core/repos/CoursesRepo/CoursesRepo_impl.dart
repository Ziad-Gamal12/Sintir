import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
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
          subCollectionKey:
              BackendEndpoints.addCourseToUserDocSubCollectioName);
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
      List? data = await datebaseservice.getData(
        query: {
          "state": BackendEndpoints.coursePublishedState,
          "orderBy": "postedDate"
        },
        key: BackendEndpoints.getRecentCoursesCollection,
      );
      if (data == null) return right([]);
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from CoursesrepoImpl.getRecentCourses in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getPopularCourses() async {
    try {
      List data = await datebaseservice.getData(
        query: {
          "state": BackendEndpoints.coursePublishedState,
          "orderBy": "subscripersCount",
          "limit": 10
        },
        key: BackendEndpoints.getPopularCoursesCollection,
      );
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from CoursesrepoImpl.getRecentCourses in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getMyCourses() async {
    try {
      List data = await datebaseservice.getData(
          key: getUsersCollectionName(),
          docId: await getUId(),
          subCollectionKey:
              BackendEndpoints.getCoursesfromUserDocSubCollectioName);
      if (data.isEmpty) return right([]);
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      log("Exception from CoursesrepoImpl.getMyCourses in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  String getUsersCollectionName() {
    String role = shared_preferences_Services.stringGetter(
        key: BackendEndpoints.userKind);
    if (role == "teacher") {
      return BackendEndpoints.getTeacherDataCollectionName;
    } else {
      return BackendEndpoints.getStudentDataCollectionName;
    }
  }

  Future<String> getUId() async {
    return FirebaseAuth.instance.currentUser!.uid;
  }
}
