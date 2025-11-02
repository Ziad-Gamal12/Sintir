// ignore_for_file: file_names

import 'dart:developer';
import 'dart:isolate';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/entities/GetCourseSectionsResonseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseSectionModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursefileModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursevedioitemModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';

class CourseSectionsRepoImpl implements CourseSectionsRepo {
  final Databaseservice datebaseservice;
  CourseSectionsRepoImpl({
    required this.datebaseservice,
  });

  @override
  Future<Either<Failure, void>> addCourseSection({
    required String courseId,
    required CourseSectionEntity section,
  }) async {
    try {
      final json = CourseSectionModel.fromEntity(
        coursSectionsListItemEntity: section,
      ).toJson();

      await datebaseservice.setData(
        data: json,
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: section.id,
        ),
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log("add course section error $e $s");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  DocumentSnapshot? getCourseSectionsLastDoc;
  final Map<String, dynamic> _baseQuery = {
    "startAfter": null,
    "limit": 10,
  };

  @override
  Future<Either<Failure, GetCourseSectionsResonseEntity>> getCourseSections({
    required String courseId,
    required bool isPaginate,
  }) async {
    try {
      final query = Map<String, dynamic>.from(_baseQuery);
      query["startAfter"] = isPaginate ? getCourseSectionsLastDoc : null;
      final response = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
        ),
        query: query,
      );

      if (response.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (response.listData!.isEmpty) {
        return right(GetCourseSectionsResonseEntity(
          isPaginate: isPaginate,
          sections: [],
          hasMore: false,
        ));
      }

      if (response.lastDocumentSnapshot != null) {
        getCourseSectionsLastDoc = response.lastDocumentSnapshot;
      }

      final courseSections =
          await compute(_parseCourseSections, response.listData!);

      return right(GetCourseSectionsResonseEntity(
        isPaginate: isPaginate,
        sections: courseSections,
        hasMore: response.hasMore ?? false,
      ));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  static List<CourseSectionEntity> _parseCourseSections(List<dynamic> data) {
    return data.map((e) => CourseSectionModel.fromJson(e).toEntity()).toList();
  }

  @override
  Future<Either<Failure, void>> addSectionItem({
    required dynamic sectionItem,
    required String courseId,
    required String sectionId,
  }) async {
    try {
      if (sectionItem is! CourseTestEntity &&
          sectionItem is! CourseVideoItemEntity &&
          sectionItem is! CourseFileEntity) {
        return left(
            ServerFailure(message: "العنصر غير معرف, يرجى المحاولة مرة أخرى"));
      }
      final json = await Isolate.run(() => _getSectionItemData(sectionItem));
      await datebaseservice.setData(
        data: json,
        requirements: getAddingSectionItemRequirments(
          rootCollection: BackendEndpoints.coursesCollection,
          rootDocId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
          sub2DocId: (sectionItem.id) as String,
        ),
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  static Map<String, dynamic> _getSectionItemData(dynamic sectionItem) {
    if (sectionItem is CourseTestEntity) {
      return Coursetestmodel.fromEntity(sectionItem).toJson();
    } else if (sectionItem is CourseVideoItemEntity) {
      return Coursevedioitemmodel.fromEntity(sectionItem).toJson();
    } else if (sectionItem is CourseFileEntity) {
      return Coursefilemodel.fromEntity(sectionItem).toJson();
    } else {
      return {};
    }
  }

  FireStoreRequirmentsEntity getAddingSectionItemRequirments({
    required String rootCollection,
    required String rootDocId,
    required String subCollection,
    required String subDocId,
    required String subCollection2,
    required String sub2DocId,
    String? subCollection3,
    String? sub3DocId,
  }) {
    return FireStoreRequirmentsEntity(
      collection: rootCollection,
      docId: rootDocId,
      subCollection: subCollection,
      subDocId: subDocId,
      subCollection2: subCollection2,
      sub2DocId: sub2DocId,
      subCollection3: subCollection3,
      sub3DocId: sub3DocId,
    );
  }

  @override
  Future<Either<Failure, List>> getSectionsItems({
    required String courseId,
    required String sectionId,
  }) async {
    try {
      final data = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
        ),
      );

      if (data.listData == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (data.listData!.isEmpty) {
        return right([]);
      }

      final items = await compute(_parseSectionItems, data.listData!);

      return right(items);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  static List _parseSectionItems(List<dynamic> listData) {
    final items = [];
    for (var item in listData) {
      if (item["type"] == "Test") {
        items.add(Coursetestmodel.fromJson(item).toEntity());
      } else if (item["type"] == "Video") {
        items.add(Coursevedioitemmodel.fromJson(item).toEntity());
      } else {
        items.add(Coursefilemodel.fromJson(item).toEntity());
      }
    }
    return items;
  }

  @override
  Future<Either<Failure, void>> deleteSection(
      {required String courseId, required String sectionId}) async {
    try {
      await datebaseservice.deleteDoc(
        collectionKey: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollectionKey: BackendEndpoints.sectionsSubCollection,
        subDocId: sectionId,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSectionItem(
      {required String courseId,
      required String sectionId,
      required String sectionItemId}) async {
    try {
      await datebaseservice.deleteDoc(
        collectionKey: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollectionKey: BackendEndpoints.sectionsSubCollection,
        subDocId: sectionId,
        subCollectionKey2: BackendEndpoints.sectionItemsSubCollection,
        subDocId2: sectionItemId,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
