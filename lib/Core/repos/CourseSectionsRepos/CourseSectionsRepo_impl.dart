// ignore_for_file: file_names

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseSectionModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CourseTestModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursefileModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursevedioitemModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';

class CourseSectionsRepoImpl implements CourseSectionsRepo {
  final Pickerassetsservice pickerassetsservice;
  final StorageService storageService;
  final Datebaseservice datebaseservice;
  CourseSectionsRepoImpl(
      {required this.pickerassetsservice,
      required this.datebaseservice,
      required this.storageService});

  @override
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<Coursetestquestionentity> questions}) async {
    try {
      for (var question in questions) {
        if (question.imageFile != null) {
          String url =
              await storageService.uploadFile(file: question.imageFile!);
          question.imageUrl = url;
        }
      }
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> addCourseSection(
      {required String courseId,
      required CourseSectionEntity section,
      required sectionItem}) async {
    try {
      var json =
          CourseSectionModel.fromEntity(coursSectionsListItemEntity: section)
              .toJson();
      await datebaseservice.setData(
          data: json,
          key: BackendEndpoints.addCourseSectionCollection,
          docId: courseId,
          subCollectionKey: BackendEndpoints.sectionsSubCollection,
          subDocId: section.id);
      Either<Failure, void> result = await addSectionItem(
        sectionItem: sectionItem,
        courseId: courseId,
        sectionId: section.id,
      );

      return result;
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadVideo(
      {required Coursevedioitementity coursevedioitementity}) async {
    try {
      String url =
          await storageService.uploadFile(file: coursevedioitementity.file!);

      return right(url);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, String>> uploadFile(
      {required Coursefileentity coursefileEntity}) async {
    try {
      String url =
          await storageService.uploadFile(file: coursefileEntity.file!);

      return right(url);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, List<CourseSectionEntity>>> getCourseSections(
      {required String courseId}) async {
    try {
      List sections = await datebaseservice.getData(
          key: BackendEndpoints.getCourseSectionsCollection,
          docId: courseId,
          subCollectionKey: BackendEndpoints.getCourseSectionsSubCollection);
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
    required sectionItem,
    required String courseId,
    required sectionId,
  }) async {
    try {
      if (sectionItem is Coursetestentity) {
        Map<String, dynamic> json =
            Coursetestmodel.fromEntity(sectionItem).toJson();
        await datebaseservice.setData(
            key: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollectionKey: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2Key: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: sectionItem.id,
            data: json);
        return right(null);
      } else if (sectionItem is Coursevedioitementity) {
        Map<String, dynamic> json =
            Coursevedioitemmodel.fromEntity(sectionItem).toJson();
        await datebaseservice.setData(
            key: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollectionKey: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2Key: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: sectionItem.id,
            data: json);
        return right(null);
      } else if (sectionItem is Coursefileentity) {
        Map<String, dynamic> json =
            Coursefilemodel.fromEntity(sectionItem).toJson();
        await datebaseservice.setData(
            key: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollectionKey: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2Key: BackendEndpoints.sectionItemsSubCollection,
            sub2DocId: sectionItem.id,
            data: json);
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

  @override
  Future<Either<Failure, List>> getSectionsItems(
      {required String courseId, required String sectionId}) async {
    try {
      List items = [];
      List? data = await datebaseservice.getData(
          key: BackendEndpoints.coursesCollection,
          docId: courseId,
          subCollectionKey: BackendEndpoints.sectionsSubCollection,
          subDocId: sectionId,
          subCollection2Key: BackendEndpoints.sectionItemsSubCollection);
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
      log("Exception from CourseSectionsrepoImpl.getSectionsItems in catch With Firebase Exception: ${e.toString()}");
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
