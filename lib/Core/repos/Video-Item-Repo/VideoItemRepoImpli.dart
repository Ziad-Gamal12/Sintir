import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/VideoUploadSessionEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetVideoItemNotesResponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/VideoUploadService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/data/models/VideoNoteModel.dart';
import 'package:sintir/Features/CourseManagementAndInteractionFeature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/locale_keys.dart';

class VideoItemRepoImpli implements VideoItemRepo {
  final DataBaseService databaseservice;
  final VideoUploadService videoUploadService;
  VideoItemRepoImpli(
      {required this.videoUploadService, required this.databaseservice});
  VideoUploadSessionEntity? _activeSession;
  String? _activeUploadKey;
  CancelToken? _activeCancelToken;
  String? _activeCourseId, _activeSectionId;

  @override
  Future<Either<Failure, VideoUploadSessionEntity>> uploadVideo(
      {required CourseVideoItemEntity coursevedioitementity,
      required String courseId,
      required String sectionId,
      void Function(double progress, int uploadedBytes, int totalBytes)?
          onProgress}) async {
    try {
      final file = coursevedioitementity.file;
      if (file == null) throw StateError('Choose a video file first.');
      final key = '$courseId/$sectionId/${file.path}';
      if (_activeSession == null || _activeUploadKey != key) {
        _activeSession = await videoUploadService.createUpload(
            courseId: courseId,
            sectionId: sectionId,
            title: coursevedioitementity.title,
            description: '',
            file: file);
        _activeUploadKey = key;
        _activeCourseId = courseId;
        _activeSectionId = sectionId;
      }
      final token = CancelToken();
      _activeCancelToken = token;
      await videoUploadService.uploadFile(
          file: file,
          session: _activeSession!,
          onProgress: (progress, uploaded, total) =>
              onProgress?.call(progress, uploaded, total),
          cancelToken: token);
      coursevedioitementity.id = _activeSession!.videoId;
      coursevedioitementity.videoProvider = 'mux';
      coursevedioitementity.muxUploadId = _activeSession!.uploadId;
      coursevedioitementity.status = 'uploading';
      final completedSession = _activeSession!;
      _activeSession = null;
      _activeUploadKey = null;
      return right(completedSession);
    } catch (e) {
      log('Video upload failed: $e');
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    } finally {
      _activeCancelToken = null;
    }
  }

  @override
  Future<void> cancelVideoUpload() async {
    _activeCancelToken?.cancel('Cancelled by user.');
    final session = _activeSession;
    final courseId = _activeCourseId;
    final sectionId = _activeSectionId;
    _activeSession = null;
    _activeUploadKey = null;
    if (session != null && courseId != null && sectionId != null) {
      await videoUploadService.cancel(
          courseId: courseId, sectionId: sectionId, videoId: session.videoId);
    }
  }

  @override
  Future<Either<Failure, String>> getPlaybackUrl(
      {required String courseId,
      required String sectionId,
      required String videoId}) async {
    try {
      final data = await videoUploadService.playback(
          courseId: courseId, sectionId: sectionId, videoId: videoId);
      return right(data['playbackUrl'] as String);
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.videoPlayFailed));
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
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  @override
  Future<Either<Failure, int>> getAttendedCount(
      {required String courseId,
      required String sectionId,
      required String videoId}) async {
    try {
      final response = await databaseservice.getCollectionItemsCount(
          requirements: FireStoreRequirmentsEntity(
        collection: BackendEndpoints.coursesCollection,
        docId: courseId,
        subCollection: BackendEndpoints.sectionsSubCollection,
        subDocId: sectionId,
        subCollection2: BackendEndpoints.sectionItemsSubCollection,
        sub2DocId: videoId,
        subCollection3: BackendEndpoints.joinedBySubCollection,
      ));
      return right(response);
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }

  DocumentSnapshot<Object?>? getVideNotesLastDoc;
  Map<String, dynamic> getVideNotesQuery = {
    "orderBy": "dateTime",
    "limit": 10,
    "startAfter": null
  };
  @override
  Future<Either<Failure, GetVideoItemNotesResponseEntity>> getVideoItemNotes(
      {required String courseId,
      required String sectionId,
      required bool isPaginate,
      required String videoId}) async {
    try {
      getVideNotesQuery["startAfter"] = isPaginate ? getVideNotesLastDoc : null;
      final response = await databaseservice.getData(
          requirements: FireStoreRequirmentsEntity(
            collection: BackendEndpoints.coursesCollection,
            docId: courseId,
            subCollection: BackendEndpoints.sectionsSubCollection,
            subDocId: sectionId,
            subCollection2: BackendEndpoints.courseSectionItemsCollectionName,
            sub2DocId: videoId,
            subCollection3: BackendEndpoints.videoNotesSubCollection,
          ),
          query: getVideNotesQuery);
      if (response.listData == null) {
        return left(ServerFailure(message: LocaleKeys.dataNotFound));
      }
      if (response.listData!.isEmpty) {
        return right(
          GetVideoItemNotesResponseEntity(
              notes: [], hasMore: false, isPaginate: isPaginate),
        );
      }
      if (response.lastDocumentSnapshot != null) {
        getVideNotesLastDoc = response.lastDocumentSnapshot;
      }
      List<VideoNoteEntity> notes = [];
      notes = await compute(
          _parseVideoNotes, response.listData! as List<Map<String, dynamic>>);
      bool hasMore = response.hasMore ?? false;
      return right(GetVideoItemNotesResponseEntity(
          notes: notes, hasMore: hasMore, isPaginate: isPaginate));
    } on CustomException catch (e) {
      return left(ServerFailure(message: e.message));
    } catch (e) {
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

List<VideoNoteEntity> _parseVideoNotes(List<Map<String, dynamic>> data) {
  return data.map((e) => VideoNoteModel.fromJson(e).toEntity()).toList();
}
