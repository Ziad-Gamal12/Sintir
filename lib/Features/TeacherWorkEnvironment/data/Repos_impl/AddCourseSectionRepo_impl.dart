import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sintir/Core/entities/CourseEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/services/DateBaseService.dart';
import 'package:sintir/Core/services/PickerAssetsService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/CoursSectionsListItemsModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseFileEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseTestQuestionEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/CourseVedioItemEntity.dart';
import 'package:sintir/Features/TeacherWorkEnvironment/domain/repos/AddCourseSectionRepo.dart';

class AddcoursesectionrepoImpl implements Addcoursesectionrepo {
  final Pickerassetsservice pickerassetsservice;
  final StorageService storageService;
  final Datebaseservice datebaseservice;
  AddcoursesectionrepoImpl(
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
  Future<Either<Failure, void>> updateCourseSections({
    required CourseEntity courseEntity,
  }) async {
    try {
      List<Map<String, dynamic>> sections =
          courseEntity.coursSectionsListItemEntity!.map((e) {
        return Courssectionslistitemsmodel.fromEntity(
                coursSectionsListItemEntity: e)
            .toJson();
      }).toList();
      await addSectiontoCoursesCollection(courseEntity, sections);
      await addCourseSectionToTeacherSubCollection(courseEntity, sections);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    }
  }

  Future<void> addCourseSectionToTeacherSubCollection(
      CourseEntity courseEntity, List<Map<String, dynamic>> sections) async {
    var field = "coursSectionsListItemEntity";
    await datebaseservice.updateDate(
        field: field,
        doc: FirebaseAuth.instance.currentUser!.uid,
        collectionKey: BackendEndpoints.addSectionToTeacherCollection,
        subCollectionKey:
            BackendEndpoints.addCourseSectiontoTeacherSubCollection,
        subDocId: courseEntity.id,
        data: sections);
  }

  Future<void> addSectiontoCoursesCollection(
      CourseEntity courseEntity, List<Map<String, dynamic>> sections) async {
    var field = "coursSectionsListItemEntity";
    await datebaseservice.updateDate(
        field: field,
        doc: courseEntity.id,
        collectionKey: BackendEndpoints.addCourseSectionCollection,
        data: sections);
  }

  @override
  Future<Either<Failure, void>> uploadVideo(
      {required Coursevedioitementity coursevedioitementity}) async {
    try {
      String url =
          await storageService.uploadFile(file: coursevedioitementity.file!);
      coursevedioitementity.vedioUrl = url;
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> uploadFile(
      {required Coursefileentity coursefileEntity}) async {
    try {
      String url =
          await storageService.uploadFile(file: coursefileEntity.file!);
      coursefileEntity.fileUrl = url;
      return right(null);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
