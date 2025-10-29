import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/models/contentCreaterModel.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Search/Domain/Entities/SearchResponse.dart';
import 'package:sintir/Features/Search/Domain/Repos/SearchRepo.dart';

class SearchRepoImpl implements SearchRepo {
  final Databaseservice databaseservice;
  SearchRepoImpl({required this.databaseservice});

  @override
  Future<Either<Failure, SearchResponse>> search({
    required String keyword,
  }) async {
    try {
      final results = await Future.wait([
        searchCourses(
          keyword: keyword,
        ),
        searchTeachers(
          keyword: keyword,
        ),
        searchCoursesByContentCreatorName(
          keyword: keyword,
        ),
      ]);
      final searchCoursesResponse = results[0];
      final searchTeachersResponse = results[1];
      final searchCoursesByContentCreatorResponse = results[2];

      // Merge & remove duplicates by using map with IDs as keys
      final allCoursesMap = {
        for (var course in [
          ...searchCoursesResponse.fetchedTeachersCoursesList,
          ...searchCoursesByContentCreatorResponse.fetchedTeachersCoursesList,
          ...searchTeachersResponse.fetchedTeachersCoursesList,
        ])
          course.id: course,
      };

      final allTeachersMap = {
        for (var teacher in [
          ...searchTeachersResponse.fetchedTeachersList,
          ...searchCoursesByContentCreatorResponse.fetchedTeachersList,
          ...searchCoursesResponse.fetchedTeachersList,
        ])
          teacher.id: teacher,
      };

      return Right(
        SearchResponse(
          fetchedTeachersCoursesList: allCoursesMap.values.toList(),
          fetchedTeachersList: allTeachersMap.values.toList(),
        ),
      );
    } on CustomException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(
          ServerFailure(message: "حدث خطأ ما يرجى المحاولة في وقت لاحق"));
    }
  }

  // ---------------------- SEARCH COURSES ----------------------

  Map<String, dynamic> searchCoursesQuery = {
    "limit": 10,
    "searchField": "title",
    "searchValue": "",
    "filters": [
      {
        "field": "state",
        "operator": "==",
        "value": BackendEndpoints.coursePublishedState,
      },
    ],
  };

  @override
  Future<SearchResponse> searchCourses({
    required String? keyword,
  }) async {
    searchCoursesQuery["searchValue"] = keyword;

    final response = await databaseservice.getData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
      ),
      query: searchCoursesQuery,
    );

    if (response.listData == null || response.listData!.isEmpty) {
      return SearchResponse(
        fetchedTeachersCoursesList: [],
        fetchedTeachersList: [],
      );
    }

    List<CourseEntity> fetchedCourses = await compute(
      _parseCourses,
      response.listData! as List<Map<String, dynamic>>,
    );

    List<Contentcreaterentity> fetchedTeachers = fetchedCourses
        .where((e) => e.contentcreaterentity != null)
        .map((e) => e.contentcreaterentity!)
        .toList();

    return SearchResponse(
      fetchedTeachersCoursesList: fetchedCourses,
      fetchedTeachersList: fetchedTeachers,
    );
  }

  // ---------------------- SEARCH TEACHERS ----------------------

  Map<String, dynamic> searchTeachersQuery = {
    "limit": 10,
    "searchField": "fullName",
    "searchValue": "",
    "filters": [
      {
        "field": "status",
        "operator": "==",
        "value": BackendEndpoints.activeStatus,
      },
      {
        "field": "role",
        "operator": "==",
        "value": BackendEndpoints.teacherRole,
      },
    ],
  };

  @override
  Future<SearchResponse> searchTeachers({
    required String? keyword,
  }) async {
    searchTeachersQuery["searchValue"] = keyword;

    final response = await databaseservice.getData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
      ),
      query: searchTeachersQuery,
    );

    if (response.listData == null || response.listData!.isEmpty) {
      return SearchResponse(
        fetchedTeachersCoursesList: [],
        fetchedTeachersList: [],
      );
    }
    List<Contentcreaterentity> fetchedTeachers = await compute(
      _parseTeachersFromTeacherJson,
      response.listData! as List<Map<String, dynamic>>,
    );
    return SearchResponse(
      fetchedTeachersCoursesList: [],
      fetchedTeachersList: fetchedTeachers,
    );
  }

  // ---------------------- SEARCH COURSES BY CONTENT CREATOR ----------------------

  Map<String, dynamic> searchCoursesByContentCreatorQuery = {
    "limit": 10,
    "searchField": "contentcreaterentity.name",
    "searchValue": "",
    "filters": [
      {
        "field": "state",
        "operator": "==",
        "value": BackendEndpoints.coursePublishedState,
      },
    ],
  };

  @override
  Future<SearchResponse> searchCoursesByContentCreatorName({
    required String keyword,
  }) async {
    searchCoursesByContentCreatorQuery["searchValue"] = keyword;

    final response = await databaseservice.getData(
      requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
      ),
      query: searchCoursesByContentCreatorQuery,
    );

    if (response.listData == null || response.listData!.isEmpty) {
      return SearchResponse(
        fetchedTeachersCoursesList: [],
        fetchedTeachersList: [],
      );
    }

    List<CourseEntity> fetchedCourses = await compute(
      _parseCourses,
      response.listData! as List<Map<String, dynamic>>,
    );
    List<Contentcreaterentity> fetchedTeachers = fetchedCourses
        .where((e) => e.contentcreaterentity != null)
        .map((e) => e.contentcreaterentity!)
        .toList();
    return SearchResponse(
      fetchedTeachersCoursesList: fetchedCourses,
      fetchedTeachersList: fetchedTeachers,
    );
  }

  @override
  Future<Either<Failure, SearchResponse>> getDefaultCourses() async {
    try {
      final response = await searchCourses(
        keyword: null,
      );
      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }

  @override
  Future<Either<Failure, SearchResponse>> getDefaultTeachers() async {
    try {
      final response = await searchTeachers(
        keyword: null,
      );
      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }
}

// ---------------------- PARSING HELPERS ----------------------

List<CourseEntity> _parseCourses(List<Map<String, dynamic>> listData) {
  return listData.map((e) => Coursemodel.fromJson(e).toEntity()).toList();
}

List<Contentcreaterentity> _parseTeachersFromTeacherJson(
    List<Map<String, dynamic>> listData) {
  return listData
      .map((e) => Contentcreatermodel.fromTeacherJson(data: e).toEntity())
      .toList();
}
