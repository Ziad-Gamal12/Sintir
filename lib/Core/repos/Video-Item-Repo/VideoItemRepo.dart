// ignore_for_file: file_names
import 'package:dartz/dartz.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/VideoUploadSessionEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetVideoItemNotesResponseEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/VideoNoteEntity.dart';

abstract class VideoItemRepo {
  Future<Either<Failure, VideoUploadSessionEntity>> uploadVideo(
      {required CourseVideoItemEntity coursevedioitementity,
      required String courseId,
      required String sectionId,
      void Function(double progress, int uploadedBytes, int totalBytes)?
          onProgress});
  Future<void> cancelVideoUpload();
  Future<Either<Failure, String>> getPlaybackUrl(
      {required String courseId,
      required String sectionId,
      required String videoId});
  Future<Either<Failure, void>> addVideoNote(
      {required String coursId,
      required String sectionId,
      required String videoId,
      required VideoNoteEntity note});
  Future<Either<Failure, int>> getAttendedCount(
      {required String courseId,
      required String sectionId,
      required String videoId});
  Future<Either<Failure, GetVideoItemNotesResponseEntity>> getVideoItemNotes(
      {required String courseId,
      required String sectionId,
      required bool isPaginate,
      required String videoId});
}
