import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:meta/meta.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/AssetsPickerRepo/AssetsPickerRepo.dart';
import 'package:sintir/Core/repos/SectionItemsActionsRepo/SectionItemsActionRepo.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/JoinedByEntity.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';

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

  void pickVideoFile(
      {required CourseVideoItemEntity coursevedioitementity}) async {
    final result = await assetspickerrepo.pickVideoFromGallery();
    result.fold((failure) {
      emit(PickVideoFileFailure(errMessage: failure.message));
    }, (vedio) {
      coursevedioitementity.file = vedio;
      emit(PickVideoFileSuccess(file: vedio));
    });
  }

  void uploadVideo({
    required CourseVideoItemEntity coursevedioitementity,
  }) async {
    emit(UploadVideoLoading());
    var result = await videoItemRepo.uploadVideo(
        coursevedioitementity: coursevedioitementity);
    result.fold((failure) {
      emit(UploadVideoFailure(errMessage: failure.message));
    }, (url) {
      emit(UploadVideoSuccess(url: url));
    });
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
