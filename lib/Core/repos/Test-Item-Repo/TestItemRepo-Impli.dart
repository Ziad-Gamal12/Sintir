import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/CourseTestQuestionEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseTestItemEntities/TestResulteEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Test-Item-Repo/TestItemRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/TestResulteModel.dart';

class Testitemrepoimpli implements Testitemrepo {
  final StorageService storageService;
  final Databaseservice datebaseservice;

  Testitemrepoimpli(
      {required this.storageService, required this.datebaseservice});
  @override
  Future<Either<Failure, void>> uploadTestQuestionsImages(
      {required List<CourseTestQuestionEntity> questions}) async {
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
  Future<Either<Failure, void>> addTestResult(
      {required TestresulteEntity testResult,
      required String courseId,
      required String sectionId,
      required String sectionItemId}) async {
    try {
      Map<String, dynamic> json =
          Testresultemodel.fromEntity(testResult).toJson();
      await datebaseservice.setData(
          requirements: FireStoreRequirmentsEntity(
              collection: BackendEndpoints.coursesCollection,
              docId: courseId,
              subCollection: BackendEndpoints.sectionsSubCollection,
              subDocId: sectionId,
              subCollection2: BackendEndpoints.sectionItemsSubCollection,
              sub2DocId: sectionItemId,
              subCollection3: BackendEndpoints.testResultsSubCollection,
              sub3DocId: testResult.serialNumber),
          data: json);
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
