import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as path;
import 'package:sintir/Core/utils/video_file_limits.dart';
import 'package:sintir/locale_keys.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/VideoUploadSessionEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/VideoNoteEntity.dart';

part 'video_item_state.dart';

class VideoItemCubit extends Cubit<VideoItemState> {
  VideoItemCubit(
      {required this.videoItemRepo,
      required this.assetspickerrepo,
      required this.sectionItemsActionsRepo})
      : super(VideoItemInitial());
  final VideoItemRepo videoItemRepo;
  final SectionItemsActionsRepo sectionItemsActionsRepo;
  final Assetspickerrepo assetspickerrepo;

  void addVideoItem({
    required String courseId,
    required String sectionId,
    required CourseVideoItemEntity video,
  }) async {
    emit(AddVideoItemLoading());
    final result = await sectionItemsActionsRepo.addSectionItem(
        sectionItem: video, courseId: courseId, sectionId: sectionId);
    result.fold((failure) {
      emit(AddVideoItemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddVideoItemSuccess());
    });
  }

  Future<void> pickVideoFile(
      {required CourseVideoItemEntity coursevedioitementity}) async {
    final result = await assetspickerrepo.pickVideoFromGallery();
    final file = result.fold<File?>((failure) {
      emit(PickVideoFileFailure(errMessage: failure.message));
      return null;
    }, (picked) => picked);
    if (file == null) return;
    final extension = path.extension(file.path).toLowerCase();
    if (extension != '.mp4' && extension != '.mov') {
      emit(PickVideoFileFailure(
          errMessage: LocaleKeys.videoUnsupportedFileType));
      return;
    }
    final size = await file.length();
    if (size > maxVideoSizeBytes) {
      emit(PickVideoFileFailure(
          errMessage:
              LocaleKeys.videoFileTooLarge(maxVideoSizeMegabytes.toString())));
      return;
    }
    coursevedioitementity.file = file;
    emit(PickVideoFileSuccess(file: file));
  }

  Future<void> clearSelectedVideo() async {
    await videoItemRepo.cancelVideoUpload();
    emit(VideoFileCleared());
  }

  Future<void> uploadVideo(
      {required CourseVideoItemEntity coursevedioitementity,
      required String courseId,
      required String sectionId}) async {
    final file = coursevedioitementity.file;
    if (file == null) return;
    final extension = path.extension(file.path).toLowerCase();
    if (extension != '.mp4' && extension != '.mov') {
      emit(UploadVideoFailure(errMessage: LocaleKeys.videoUnsupportedFileType));
      return;
    }
    final totalBytes = await file.length();
    if (totalBytes > maxVideoSizeBytes) {
      emit(UploadVideoFailure(
          errMessage:
              LocaleKeys.videoFileTooLarge(maxVideoSizeMegabytes.toString())));
      return;
    }
    final timer = Stopwatch()..start();
    var lastSampleAt = Duration.zero;
    var lastSampleBytes = 0;
    double? smoothedBytesPerSecond;
    emit(UploadVideoLoading(progress: 0, totalBytes: totalBytes));
    final result = await videoItemRepo.uploadVideo(
      coursevedioitementity: coursevedioitementity,
      courseId: courseId,
      sectionId: sectionId,
      onProgress: (progress, uploaded, total) {
        final now = timer.elapsed;
        final interval = (now - lastSampleAt).inMilliseconds / 1000;
        final deltaBytes = uploaded - lastSampleBytes;
        if (interval >= 0.5 && deltaBytes > 0) {
          final sampleSpeed = deltaBytes / interval;
          smoothedBytesPerSecond = smoothedBytesPerSecond == null
              ? sampleSpeed
              : smoothedBytesPerSecond! * 0.7 + sampleSpeed * 0.3;
          lastSampleAt = now;
          lastSampleBytes = uploaded;
        }
        final speed = smoothedBytesPerSecond;
        final eta = speed != null && uploaded > 0 && uploaded < total
            ? ((total - uploaded) / speed).ceil()
            : null;
        emit(UploadVideoLoading(
            progress: progress,
            uploadedBytes: uploaded,
            totalBytes: total,
            etaSeconds: eta));
      },
    );
    result.fold(
        (failure) => emit(UploadVideoFailure(errMessage: failure.message)),
        (session) => emit(UploadVideoSuccess(session: session)));
  }

  Future<void> cancelVideoUpload() async {
    await videoItemRepo.cancelVideoUpload();
    emit(UploadVideoCancelled());
  }

  void joinToVideoItem({
    required JoinedByEntity joinedByEntity,
    required String courseId,
    required String sectionId,
    required String sectionItemId,
  }) async {
    emit(JoinToVideoItemLoading());
    Either<Failure, void> result = await sectionItemsActionsRepo.addJoinedBy(
        joinedByEntity: joinedByEntity,
        courseId: courseId,
        sectionId: sectionId,
        sectionItemId: sectionItemId);
    result.fold((failure) {
      emit(JoinToVideoItemFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(JoinToVideoItemSuccess());
    });
  }

  Future<void> addVideoNote(
      {required String coursId,
      required String sectionId,
      required String videoId,
      required VideoNoteEntity note}) async {
    emit(AddVideoNoteLoading());
    final result = await videoItemRepo.addVideoNote(
        coursId: coursId, sectionId: sectionId, videoId: videoId, note: note);
    result.fold((failure) {
      emit(AddVideoNoteFailure(errMessage: failure.message));
    }, (sucUpdateCourseSectionsFailurecess) {
      emit(AddVideoNoteSuccess());
    });
  }
}
