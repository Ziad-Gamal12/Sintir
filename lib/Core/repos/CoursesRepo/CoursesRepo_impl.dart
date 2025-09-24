// ignore_for_file: file_names

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/entities/GetCourseResonseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/helper/GetUID.dart';
import 'package:sintir/Core/helper/GetUserData.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/repos/CoursesRepo/CoursesRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
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
      final isExists = await databaseservice.isDataExists(
        key: BackendEndpoints.coursesCollection,
        docId: courseEntity.id,
      );
      if (isExists) {
        return left(ServerFailure(
            message:
                "هذة الدورة موجوده بالفعل يجب عليك تغيير الكود الخاص بالدورة"));
      }

      final data = Coursemodel.fromEntity(courseEntity: courseEntity).toJson();

      await Future.wait([
        databaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseEntity.id,
          ),
          data: data,
        ),
        databaseservice.setData(
          data: data,
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
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, String>> uplaodFile({required File file}) async {
    try {
      final url = await storageService.uploadFile(file: file);
      return right(url);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  List<CourseEntity> _parseCourses(List<dynamic> listData) {
    return listData
        .map((e) =>
            Coursemodel.fromJson(Map<String, dynamic>.from(e)).toEntity())
        .toList();
  }

  DocumentSnapshot? _recentLastDoc;
  DocumentSnapshot? _popularLastDoc;
  DocumentSnapshot? _myCoursesLastDoc;

  Future<Either<Failure, GetCoursesResonseEntity>> _getCourses({
    required Map<String, dynamic> baseQuery,
    required FireStoreRequirmentsEntity requirements,
    required DocumentSnapshot? lastDoc,
    required bool isPaginate,
    required void Function(DocumentSnapshot?) saveLastDoc,
  }) async {
    try {
      final query = {...baseQuery};
      query["startAfter"] = isPaginate ? lastDoc : null;

      final data = await databaseservice.getData(
        query: query,
        requirements: requirements,
      );

      if (data.listData == null) {
        return right(GetCoursesResonseEntity(courses: [], hasMore: false));
      }

      if (data.listData!.isNotEmpty && data.lastDocumentSnapshot != null) {
        saveLastDoc(data.lastDocumentSnapshot);
      }

      final courses = await compute(_parseCourses, data.listData!);
      return right(
        GetCoursesResonseEntity(
            courses: courses, hasMore: data.hasMore ?? false),
      );
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getRecentCourses(
      {required bool isPaginate}) {
    return _getCourses(
      baseQuery: {
        "filters": [
          {
            "field": "state",
            "operator": "==",
            "value": BackendEndpoints.coursePublishedState,
          }
        ],
        "orderBy": "postedDate",
        "descending": false,
        "limit": 10,
      },
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
      ),
      lastDoc: _recentLastDoc,
      isPaginate: isPaginate,
      saveLastDoc: (doc) => _recentLastDoc = doc,
    );
  }

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getPopularCourses(
      {required bool isPaginate}) {
    return _getCourses(
      baseQuery: {
        "filters": [
          {
            "field": "state",
            "operator": "==",
            "value": BackendEndpoints.coursePublishedState,
          }
        ],
        "orderBy": "studentsCount",
        "limit": 10,
      },
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
      ),
      lastDoc: _popularLastDoc,
      isPaginate: isPaginate,
      saveLastDoc: (doc) => _popularLastDoc = doc,
    );
  }

  @override
  Future<Either<Failure, GetCoursesResonseEntity>> getMyCourses(
      {required bool isPaginate}) {
    return _getCourses(
      baseQuery: {
        "limit": 10,
      },
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: getUserData().uid,
        subCollection: BackendEndpoints.getCoursesfromUserDocSubCollectioName,
      ),
      lastDoc: _myCoursesLastDoc,
      isPaginate: isPaginate,
      saveLastDoc: (doc) => _myCoursesLastDoc = doc,
    );
  }

  @override
  Future<Either<Failure, void>> updateCourse(
      {required CourseEntity courseEntity}) async {
    try {
      final data = Coursemodel.fromEntity(courseEntity: courseEntity).toJson();

      await Future.wait([
        databaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseEntity.id,
          ),
          data: data,
        ),
        databaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.teachersCollection,
            docId: getUID(),
            subCollection: BackendEndpoints.coursesCollection,
            subDocId: courseEntity.id,
          ),
          data: data,
        ),
      ]);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
