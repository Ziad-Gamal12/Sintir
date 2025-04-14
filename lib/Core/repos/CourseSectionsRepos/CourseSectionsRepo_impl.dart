// ignore_for_file: file_names

import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/CourseSectionsRepos/CourseSectionsRepo.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursSectionsListItemsModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CoursSectionsListItemEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
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
      {required String courseId, required CourseSectionEntity section}) async {
    try {
      var json =
          CourseSectionModel.fromEntity(coursSectionsListItemEntity: section)
              .toJson();
      await datebaseservice.setData(
          data: json,
          key: BackendEndpoints.addCourseSectionCollection,
          docId: courseId,
          subCollectionKey: BackendEndpoints.sectionsSubCollection);
      await addCourseSectionToTeacherSubCollection(
          json: json, courseId: courseId);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  Future<void> addCourseSectionToTeacherSubCollection(
      {required Map<String, dynamic> json, required String courseId}) async {
    await datebaseservice.setData(
      data: json,
      docId: FirebaseAuth.instance.currentUser!.uid,
      key: BackendEndpoints.addSectionToTeacherCollection,
      subCollection2Key:
          BackendEndpoints.addCourseSectionCollectionToTeacherSubCollection,
      subCollectionKey: BackendEndpoints.addCourseSectiontoTeacherSubCollection,
      subDocId: courseId,
    );
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
}
