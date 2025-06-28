// ignore_for_file: file_names

import 'dart:developer';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/helper/GetUID.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/Shared_preferences.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';

class CoursesrepoImpl implements Coursesrepo {
  final Databaseservice databaseservice;
  final StorageService storageService;

  CoursesrepoImpl({
    required this.databaseservice,
    required this.storageService,
  });
  @override
  Future<Either<Failure, void>> addCourse(
      {required CourseEntity courseEntity}) async {
    try {
      bool isExists = await databaseservice.isDataExists(
          key: BackendEndpoints.coursesCollection, docId: courseEntity.id);
      if (isExists) {
        return left(ServerFailure(
            message:
                "هذة الدورة موجوده بالفعل يجب عليك تغيير الكود الخاص بالدورة"));
      }
      await Future.wait([
        databaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseEntity.id,
          ),
          data: Coursemodel.fromEntity(courseEntity: courseEntity).toJson(),
        ),
        databaseservice.setData(
          data: Coursemodel.fromEntity(courseEntity: courseEntity).toJson(),
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.teachersCollection,
            docId: courseEntity.contentcreaterentity!.id,
            subCollection: BackendEndpoints.coursesCollection,
            subDocId: courseEntity.id,
          ),
        )
      ]);
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
      return left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getRecentCourses() async {
    try {
      List? data = await databaseservice.getData(
        query: {
          "state": BackendEndpoints.coursePublishedState,
          "orderBy": "postedDate"
        },
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
        ),
      );
      if (data == null) return right([]);
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getPopularCourses() async {
    try {
      List data = await databaseservice.getData(
        query: {"state": BackendEndpoints.coursePublishedState, "limit": 10},
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
        ),
      );
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CourseEntity>>> getMyCourses() async {
    try {
      List data = await databaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
            collection: getUsersCollectionName(),
            docId: getUID(),
            subCollection:
                BackendEndpoints.getCoursesfromUserDocSubCollectioName),
      );
      if (data.isEmpty) return right([]);
      List<CourseEntity> courses =
          data.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
      return right(courses);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
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

  @override
  Future<Either<Failure, void>> updateCourse(
      {required CourseEntity courseEntity}) async {
    try {
      await databaseservice.setData(
        requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseEntity.id),
        data: Coursemodel.fromEntity(courseEntity: courseEntity).toJson(),
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
