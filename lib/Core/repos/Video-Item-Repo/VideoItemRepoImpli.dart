import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:sintir/Core/entities/CourseEntities/CourseVideoItemEntities/CourseVedioItemEntity.dart';
import 'package:sintir/Core/entities/FetchDataResponses/GetVideoItemNotesResponseEntity.dart';
import 'package:sintir/Core/entities/FireStoreEntities/FireStoreRequirmentsEntity.dart';
import 'package:sintir/Core/errors/Exceptioons.dart';
import 'package:sintir/Core/errors/Failures.dart';
import 'package:sintir/Core/repos/Video-Item-Repo/VideoItemRepo.dart';
import 'package:sintir/Core/services/DataBaseService.dart';
import 'package:sintir/Core/services/StorageService.dart';
import 'package:sintir/Core/utils/Backend_EndPoints.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/data/models/VideoNoteModel.dart';
import 'package:sintir/Features/Course%20Management%20and%20Interaction%20Feature/domain/Entities/VideoNoteEntity.dart';
import 'package:sintir/locale_keys.dart';

class VideoItemRepoImpli implements VideoItemRepo {
  final StorageService storageService;
  final DataBaseService databaseservice;

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
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
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
    } on CustomException catch (e, s) {
      log(e.message, stackTrace: s);
      return left(ServerFailure(message: e.message));
    } catch (e, s) {
      log(e.toString(), stackTrace: s);
      return left(ServerFailure(message: LocaleKeys.errorOccurredMessage));
    }
  }
}

List<VideoNoteEntity> _parseVideoNotes(List<Map<String, dynamic>> data) {
  return data.map((e) => VideoNoteModel.fromJson(e).toEntity()).toList();
}
