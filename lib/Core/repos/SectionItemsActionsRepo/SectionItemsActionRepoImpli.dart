import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/Enums/courseCounterField.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStorePaginateResponse.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseCountersRepo/CourseCountersRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CoursefileModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/CoursevedioitemModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/JoinedByModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/locale_keys.dart';

class SectionItemsActionsRepoImpli implements SectionItemsActionsRepo {
  final DataBaseService datebaseservice;
  final CourseCountersRepo courseCountersRepo;

  SectionItemsActionsRepoImpli({
    required this.datebaseservice,
    required this.courseCountersRepo,
  });

  FireStoreRequirmentsEntity _itemRequirements({
    required String courseId,
    required String sectionId,
    String? itemId,
  }) {
    return FireStoreRequirmentsEntity(
      collection: BackendEndpoints.coursesCollection,
      docId: courseId,
      subCollection: BackendEndpoints.sectionsSubCollection,
      subDocId: sectionId,
      subCollection2: BackendEndpoints.sectionItemsSubCollection,
      sub2DocId: itemId,
    );
  }

  @override
  Future<Either<Failure, void>> addSectionItem({
    required dynamic sectionItem,
    required String courseId,
    required String teacherId,
    required String sectionId,
  }) async {
    try {
      late final String itemId;
      late final Map<String, dynamic> json;
      late final CourseCounterField counterField;
      bool isMuxUpdate = false;

      if (sectionItem is CourseTestEntity) {
        itemId = sectionItem.id;
        json = Coursetestmodel.fromEntity(sectionItem).toJson();
        counterField = CourseCounterField.tests;
      } else if (sectionItem is CourseVideoItemEntity) {
        itemId = sectionItem.id;
        json = CourseVideoItemModel.fromEntity(sectionItem).toJson();
        counterField = CourseCounterField.lessons;
        isMuxUpdate = sectionItem.videoProvider == "mux";
      } else if (sectionItem is CourseFileEntity) {
        itemId = sectionItem.id;
        json = Coursefilemodel.fromEntity(sectionItem).toJson();
        counterField = CourseCounterField.lessons;
      } else {
        return left(ServerFailure(message: LocaleKeys.unexpectedError));
      }

      final requirements = _itemRequirements(
        courseId: courseId,
        sectionId: sectionId,
        itemId: itemId,
      );

      final Future<void> writeItemFuture = isMuxUpdate
          ? datebaseservice.updateData(data: json, requirements: requirements)
          : datebaseservice.setData(data: json, requirements: requirements);

      await Future.wait([
        writeItemFuture,
        courseCountersRepo.updateCourseCounters(
          courseId: courseId,
          teacherId: teacherId,
          field: counterField,
          delta: 1,
        ),
      ]);

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSectionItem({
    required String courseId,
    required String teacherId,
    required String sectionId,
    required String sectionItemId,
    required bool isTest,
  }) async {
    try {
      await Future.wait([
        datebaseservice.deleteDoc(
          collectionKey: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollectionKey: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollectionKey2: BackendEndpoints.sectionItemsSubCollection,
          subDocId2: sectionItemId,
        ),
        courseCountersRepo.updateCourseCounters(
          courseId: courseId,
          teacherId: teacherId,
          field: isTest ? CourseCounterField.tests : CourseCounterField.lessons,
          delta: -1,
        ),
      ]);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.unexpectedError));
    }
  }

  @override
  Future<Either<Failure, List>> getSectionsItems({
    required String courseId,
    required String sectionId,
  }) async {
    try {
      final FireStoreResponse data = await datebaseservice.getData(
        requirements: _itemRequirements(
          courseId: courseId,
          sectionId: sectionId,
        ),
      );
      if (data.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      if (data.listData!.isEmpty) {
        return right([]);
      }

      final items = await compute(_parseSectionItems, data.listData!);
      return right(items);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.unexpectedError));
    }
  }

  static List _parseSectionItems(List<dynamic> listData) {
    final items = [];
    for (final item in listData) {
      if (item["type"] == "Test") {
        items.add(Coursetestmodel.fromJson(item).toEntity());
      } else if (item["type"] == "Vedio" || item["type"] == "Video") {
        items.add(CourseVideoItemModel.fromJson(item).toEntity());
      } else {
        items.add(Coursefilemodel.fromJson(item).toEntity());
      }
    }
    return items;
  }

  @override
  Future<Either<Failure, void>> addJoinedBy({
    required JoinedByEntity joinedByEntity,
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    try {
      final Map<String, dynamic> json = JoinedbyModel.fromEntity(
        joinedByEntity,
      ).toJson();
      await datebaseservice.setData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
          sub2DocId: sectionItemId,
          subCollection3: BackendEndpoints.joinedBySubCollection,
          sub3DocId: joinedByEntity.uid,
        ),
        data: json,
      );
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (_) {
      return left(ServerFailure(message: LocaleKeys.unexpectedError));
    }
  }
}
