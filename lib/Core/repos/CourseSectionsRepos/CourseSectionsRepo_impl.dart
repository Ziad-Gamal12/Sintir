// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseSectionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
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
      Map<String, dynamic> json =
          CourseSectionModel.fromEntity(coursSectionsListItemEntity: section)
              .toJson();

      await datebaseservice.setData(
        data: json,
        requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: section.id),
      );

      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CourseSectionEntity>>> getCourseSections(
      {required String courseId}) async {
    try {
      List sections = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
        ),
      );
      List<CourseSectionEntity> courseSections = sections
          .map((e) => CourseSectionModel.fromJson(e).toEntity())
          .toList();
      return right(courseSections);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> addSectionItem({
    required dynamic sectionItem,
    required String courseId,
    required String sectionId,
  }) async {
    try {
      if (sectionItem is Coursetestentity ||
          sectionItem is Coursevedioitementity ||
          sectionItem is Coursefileentity) {
        Map<String, dynamic> json =
            getSectionItemData(sectionItem: sectionItem);

        datebaseservice.setData(
            data: json,
            requirements: getAddingSectionItemRequirments(
              rootCollection: BackendEndpoints.coursesCollection,
              rootDocId: courseId,
              subCollection: BackendEndpoints.sectionsSubCollection,
              subDocId: sectionId,
              subCollection2: BackendEndpoints.sectionItemsSubCollection,
              sub2DocId: sectionItem.id as String,
            ));

        return right(null);
      } else {
        return left(
            ServerFailure(message: "العنصر غير معرف, يرجى المحاولة مرة أخرى"));
      }
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
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

  Map<String, dynamic> getSectionItemData({required dynamic sectionItem}) {
    if (sectionItem is Coursetestentity) {
      Map<String, dynamic> json =
          Coursetestmodel.fromEntity(sectionItem).toJson();
      return json;
    } else if (sectionItem is Coursevedioitementity) {
      Map<String, dynamic> json =
          Coursevedioitemmodel.fromEntity(sectionItem).toJson();
      return json;
    } else if (sectionItem is Coursefileentity) {
      Map<String, dynamic> json =
          Coursefilemodel.fromEntity(sectionItem).toJson();
      return json;
    } else {
      return {};
    }
  }

  @override
  Future<Either<Failure, List>> getSectionsItems(
      {required String courseId, required String sectionId}) async {
    try {
      List items = [];
      List? data = await datebaseservice.getData(
        requirements: FireStoreRequirmentsEntity(
          collection: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollection: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2: BackendEndpoints.sectionItemsSubCollection,
        ),
      );
      if (data == null) {
        return left(ServerFailure(message: "البيانات غير موجودة"));
      }
      if (data.isEmpty) {
        return right([]);
      }
      for (var item in data) {
        if (item["type"] == "Test") {
          items.add(Coursetestmodel.fromJson(item).toEntity());
        } else if (item["type"] == "Vedio") {
          items.add(Coursevedioitemmodel.fromJson(item).toEntity());
        } else {
          items.add(Coursefilemodel.fromJson(item).toEnity());
        }
      }
      return right(items);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
