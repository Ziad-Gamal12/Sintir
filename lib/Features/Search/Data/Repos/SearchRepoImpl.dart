import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/ContentCreaterEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/models/CourseModel.dart';
import 'package:sintir/Core/models/contentCreaterModel.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Search/Domain/Entities/CustomFilterEntity.dart';
import 'package:sintir/Features/Search/Domain/Entities/SearchResponse.dart';
import 'package:sintir/Features/Search/Domain/Repos/SearchRepo.dart';

class SearchRepoImpl implements SearchRepo {
  final DataBaseService databaseservice;
  SearchRepoImpl({required this.databaseservice});

  @override
  Future<Either<Failure, SearchResponse>> search(
      {required String keyword,
      required CourseFilterEntity? filters,
      required String? userId}) async {
    try {
      final results = await Future.wait([
        searchCourses(keyword: keyword, filters: filters, userId: userId),
        searchTeachers(
          keyword: keyword,
        ),
        searchCoursesByContentCreatorName(
            keyword: keyword, filters: filters, userId: userId),
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
      log(e.toString());
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      log(e.toString());
      return Left(
          ServerFailure(message: "حدث خطأ ما يرجى المحاولة في وقت لاحق"));
    }
  }

  // ---------------------- SEARCH COURSES ----------------------

  @override
  Future<SearchResponse> searchCourses(
      {required String? keyword,
      required CourseFilterEntity? filters,
      required String? userId}) async {
    Map<String, dynamic> searchCoursesQuery = {
      "limit": 10,
      "searchField": "title",
      "searchValue": "",
      "orderBy": null,
      "filters": <Map<String, dynamic>>[
        {
          "field": "state",
          "operator": "==",
          "value": BackendEndpoints.coursePublishedState,
        },
      ],
    };
    if (filters != null) {
      final filterMap = applyFilters(filters: filters);
      if (filterMap["filters"] != null) {
        (searchCoursesQuery["filters"] as List<Map<String, dynamic>>)
            .addAll((filterMap["filters"] as List<Map<String, dynamic>>));
      }
      if (filterMap["orderBy"] != null) {
        searchCoursesQuery["orderBy"] =
            filterMap["orderBy"] as List<Map<String, dynamic>>;
      }
    }
    searchCoursesQuery["searchValue"] = keyword;
    FireStoreRequirmentsEntity requirmentsEntity;
    if (filters != null &&
        filters.showSubscribedCourses == true &&
        userId != null) {
      requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userId,
        subCollection: BackendEndpoints.subscribetoCourseCollection,
      );
    } else {
      requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
      );
    }
    final response = await databaseservice.getData(
      requirements: requirmentsEntity,
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

  @override
  Future<SearchResponse> searchTeachers({
    required String? keyword,
  }) async {
    Map<String, dynamic> searchTeachersQuery = {
      "limit": 10,
      "searchField": "fullName",
      "searchValue": "",
      "filters": <Map<String, dynamic>>[
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

  @override
  Future<SearchResponse> searchCoursesByContentCreatorName(
      {required String keyword,
      required CourseFilterEntity? filters,
      required String? userId}) async {
    Map<String, dynamic> searchCoursesByContentCreatorQuery = {
      "limit": 10,
      "searchField": "contentcreaterentity.name",
      "searchValue": "",
      "filters": <Map<String, dynamic>>[
        {
          "field": "state",
          "operator": "==",
          "value": BackendEndpoints.coursePublishedState,
        },
      ],
    };
    if (filters != null) {
      final filterMap = applyFilters(filters: filters);
      if (filterMap["filters"] != null) {
        (searchCoursesByContentCreatorQuery["filters"]
                as List<Map<String, dynamic>>)
            .addAll(filterMap["filters"] as List<Map<String, dynamic>>);
      }
      if (filterMap["orderBy"] != null) {
        searchCoursesByContentCreatorQuery["orderBy"] = filterMap["orderBy"];
      }
    }
    searchCoursesByContentCreatorQuery["searchValue"] = keyword;
    FireStoreRequirmentsEntity requirmentsEntity;
    if (filters != null &&
        filters.showSubscribedCourses == true &&
        userId != null) {
      requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.usersCollectionName,
        docId: userId,
        subCollection: BackendEndpoints.subscribetoCourseCollection,
      );
    } else {
      requirmentsEntity = FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
      );
    }

    final response = await databaseservice.getData(
      requirements: requirmentsEntity,
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
  Future<Either<Failure, SearchResponse>> getDefaultCourses(
      {required CourseFilterEntity? filters, required String? userId}) async {
    try {
      final response =
          await searchCourses(keyword: null, filters: filters, userId: userId);

      SearchResponse searchResponse = SearchResponse(
          fetchedTeachersCoursesList: response.fetchedTeachersCoursesList,
          fetchedTeachersList: response.fetchedTeachersList);

      return right(searchResponse);
    } on CustomException catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }

  @override
  Future<Either<Failure, SearchResponse>> getDefaultTeachers() async {
    try {
      final response = await searchTeachers(
        keyword: null,
      );
      final allTeachersMap = {
        for (Contentcreaterentity contentCreator in [
          ...response.fetchedTeachersList
        ])
          contentCreator.id: contentCreator,
      };
      List<Contentcreaterentity> fetchedTeachers =
          allTeachersMap.values.toList();
      SearchResponse searchResponse = SearchResponse(
          fetchedTeachersCoursesList: [], fetchedTeachersList: fetchedTeachers);
      return right(searchResponse);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: "حدث خطاء"));
    }
  }

  Map<String, dynamic> applyFilters({required CourseFilterEntity filters}) {
    List<Map<String, dynamic>> filtersList = [];
    List<Map<String, dynamic>> orderByList = [];
    if (filters.educaionLevel != null && filters.educaionLevel!.isNotEmpty) {
      filtersList.add(
          {"field": "level", "operator": "==", "value": filters.educaionLevel});
    }
    if (filters.subject != null && filters.subject!.isNotEmpty) {
      filtersList.add(
          {"field": "subject", "operator": "==", "value": filters.subject});
    }
    if (filters.showPaidCourses != null && filters.showPaidCourses == true) {
      filtersList.add({"field": "price", "operator": ">", "value": 0});
    }
    if (filters.showFreeCourses != null && filters.showFreeCourses == true) {
      filtersList.add({"field": "price", "operator": "==", "value": 0});
    }
    if (filters.maxPrice != null && filters.maxPrice != 0) {
      filtersList
          .add({"field": "price", "operator": "<=", "value": filters.maxPrice});
    }
    if (filters.minPrice != null && filters.minPrice != 0) {
      filtersList
          .add({"field": "price", "operator": ">=", "value": filters.minPrice});
    }
    if (filters.sortByHighestPrice != null &&
        filters.sortByHighestPrice == true) {
      orderByList.add({
        "field": "price",
        "descending": true,
      });
    }
    if (filters.sortByLowestPrice != null &&
        filters.sortByLowestPrice == true) {
      orderByList.add({
        "field": "price",
        "descending": false,
      });
    }

    if (filters.sortByNewest != null && filters.sortByNewest == true) {
      orderByList.add({
        "field": "postedDate",
        "descending": true,
      });
    }
    if (filters.sortByPopularity != null && filters.sortByPopularity == true) {
      orderByList.add({
        "field": "studentsCount",
        "descending": true,
      });
    }
    Map<String, dynamic> query = {
      "filters": filtersList,
      "orderBy": orderByList
    };

    return query;
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
