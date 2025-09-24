import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/VideoNoteModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';

class VideoItemRepoImpli implements VideoItemRepo {
  final StorageService storageService;
  final Databaseservice databaseservice;

  VideoItemRepoImpli(
      {required this.storageService, required this.databaseservice});
  @override
  Future<Either<Failure, String>> uploadVideo(
      {required CourseVideoItemEntity coursevedioitementity}) async {
    try {
      String url =
          await storageService.uploadFile(file: coursevedioitementity.file!);

      return right(url);
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }

  @override
  Future<Either<Failure, void>> addVideoNote(
      {required String coursId,
      required String sectionId,
      required String videoId,
      required VideoNoteEntity note}) async {
    try {
      Map<String, dynamic> data = VideoNoteModel.fromEntity(note).toMap();
      await databaseservice.setData(
          data: data,
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: coursId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.courseSectionItemsCollectionName,
            sub2DocId: videoId,
            subCollection3: BackendEndpoints.videoNotesSubCollection,
            sub3DocId: "${DateTime.now().millisecondsSinceEpoch}",
          ));
      return right(null);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: "حدث خطأ ما"));
    }
  }
}
